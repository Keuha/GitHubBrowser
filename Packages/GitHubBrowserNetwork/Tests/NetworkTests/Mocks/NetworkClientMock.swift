//
//  File.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine
@testable import GitHubBrowserNetwork

public class NetworkClientMock: NetworkingClientProtocol {
    var callEndpointReceive: APICall?
    var callHasBennCalledXTime = 0

    public init() { }
    
    public func call<Value>(endpoint: APICall) -> AnyPublisher<Value, Error> where Value : Decodable {
        callHasBennCalledXTime += 1
        callEndpointReceive = endpoint
        let ret: Result<Value, Error> = Result.failure(NetworkError.cantCreateURL)
        return ret.publisher.eraseToAnyPublisher()
    }
}
