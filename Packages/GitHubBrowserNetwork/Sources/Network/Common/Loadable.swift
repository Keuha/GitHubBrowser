//
//  File.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import SwiftUI

/// A binding type representing a loadable value.
public typealias LoadableSubject<Value, LoadingError: Error> = Binding<Loadable<Value, LoadingError>>

public enum Loadable<Value, LoadingError: Swift.Error> {
    /// The value has not been requested yet.
    case notRequested
    /// The value is currently being loaded. Allows access to the last loaded value (if available) and a cancel bag.
    case isLoading(last: Value?, cancelBag: CancelBag)
    /// State representing value that has been successfully loaded.
    case loaded(Value)
    /// The loading process has failed with an error in the form of a typed `LoadingError`.
    case failed(LoadingError)

    /// The loaded value.
    public var value: Value? {
        switch self {
        case let .loaded(value):
            return value
        case let .isLoading(last, _):
            return last
        default:
            return nil
        }
    }

    /// The error encountered during the loading process.
    public var error: LoadingError? {
        switch self {
        case let .failed(error):
            return error
        default:
            return nil
        }
    }

    /// A boolean flag indicating whether the value is currently being loaded.
    public var isLoading: Bool {
        switch self {
        case .isLoading:
            return true
        default:
            return false
        }
    }
}

public extension Loadable {
    /// Sets the loadable state to `isLoading`, along with the last loaded value and a cancel bag.
    ///
    /// - Parameter cancelBag: The `CancelBag` to be associated with the loading process.
    mutating func setIsLoading(cancelBag: CancelBag) {
        self = .isLoading(last: value, cancelBag: cancelBag)
    }

    /// Cancels the loading process.
    mutating func cancelLoading() {
        switch self {
        case let .isLoading(last, cancelBag):
            cancelBag.cancel()
            if let lastValue = last {
                self = .loaded(lastValue)
            } else {
                self = .notRequested
            }
        default:
            break
        }
    }

    /// Maps the loaded value to a new `Loadable` state using the given transform closure.
    func map<MappedValue>(
        _ transform: (Value) -> MappedValue
    ) -> Loadable<MappedValue, LoadingError> {
        switch self {
        case .notRequested:
            return .notRequested
        case let .isLoading(last, cancelBag):
            return .isLoading(last: last.map(transform), cancelBag: cancelBag)
        case let .loaded(value):
            return .loaded(transform(value))
        case let .failed(error):
            return .failed(error)
        }
    }
}

extension Loadable: Equatable where Value: Equatable {
    /// Determines whether two loadable values are equal.
    public static func == (lhs: Loadable<Value, LoadingError>, rhs: Loadable<Value, LoadingError>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            return true
        case let (.isLoading(lhsValue, _), .isLoading(rhsValue, _)):
            return lhsValue == rhsValue
        case let (.loaded(lhsValue), .loaded(rhsValue)):
            return lhsValue == rhsValue
        case let (.failed(lhsError), .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
