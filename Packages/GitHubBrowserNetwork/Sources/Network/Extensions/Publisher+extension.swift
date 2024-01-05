//
//  Publisher+extension.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine

public extension Publisher {
    
    /// Subscribes to a publisher with a closure that receives a `Loadable` value.
    func sinkToLoadable(
        _ completion: @escaping (Loadable<Output, Error>) -> Void
    ) -> AnyCancellable {
        sink(receiveCompletion: { subscriptionCompletion in
            switch subscriptionCompletion {
            case .finished:
                break
            case let .failure(error):
                completion(.failed(error))
            }
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
}
