//
//  CancelBag.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Combine

/// A container for managing a collection of cancellable objects.
public final class CancelBag {
    /// The set of subscriptions stored in the cancel bag.
    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    /// Initializes a new instance of `CancelBag`.
    public init() {}
    
    /// Cancels all subscriptions in the cancel bag.
    public func cancel() {
        subscriptions.removeAll()
    }
}

public extension AnyCancellable {
    /// Stores the cancellable object in the given cancel bag.
    ///
    /// - Parameter cancelBag: The cancel bag to store the cancellable object in.
    func store(
        in cancelBag: CancelBag
    ) {
        cancelBag.subscriptions.insert(self)
    }
}
