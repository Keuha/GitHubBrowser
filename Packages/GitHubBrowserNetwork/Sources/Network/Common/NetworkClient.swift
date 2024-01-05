//
//  NetworkClient.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine

public struct NetworkClient: NetworkingClientProtocol {
    private let baseURL = "https://api.github.com"
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    public init(
        urlSession: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
        self.decoder.dateDecodingStrategy = .secondsSince1970
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func call<Value>(endpoint: APICall) -> AnyPublisher<Value, Error> where Value : Decodable {
        guard let url = URL(string: "\(baseURL)\(endpoint.path)") else {
            return AnyPublisher(
                Fail<Value, Error>(error: NetworkError.cantCreateURL)
            )
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        return urlSession
            .dataTaskPublisher(for: request)
            .map {
                $0.data
            }
            .decode(type: Value.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
