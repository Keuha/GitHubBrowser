//
//  NetworkingClientProtocol.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine

/// Protocol defining the networking client
public protocol NetworkingClientProtocol {
    /// Calls the API endpoint with the specified parameter encoding, returning a publisher that emits a decodable
    /// value.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to be called.
    /// - Returns: A publisher that emits a decodable value.
    func call<Value>(
        endpoint: APICall
    ) -> AnyPublisher<Value, Error> where Value: Decodable
}
