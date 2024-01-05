//
//  ObservableObject+loadableSubject.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Combine
import Foundation
import SwiftUI

public extension ObservableObject {
    /// Returns a `LoadableSubject` that wraps a key path of an `ObservableObject` into `Binding`.
    ///
    /// - Parameters:
    ///   - keyPath: The key path of the `Loadable` property within the `ObservableObject`.
    /// - Returns: A `LoadableSubject` that tracks the state of the `Loadable` property.
    func loadableSubject<
        Value,
        LoadingError
    >(_ keyPath: WritableKeyPath<Self, Loadable<Value, LoadingError>>)
        -> LoadableSubject<Value, LoadingError> {
        let defaultValue = self[keyPath: keyPath]
        return .init(get: { [weak self] in
            self?[keyPath: keyPath] ?? defaultValue
        }, set: { [weak self] in
            self?[keyPath: keyPath] = $0
        })
    }
}
