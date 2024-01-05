//
//  File.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine

public protocol SearchRepositoryProtocol {
    func searchUsers(userName: String) -> AnyPublisher<Users, Error>
}

public struct SearchRepository: SearchRepositoryProtocol {
    private let networkingClient: NetworkingClientProtocol
    
    public init(
        networkingClient: NetworkingClientProtocol
    ) {
        self.networkingClient = networkingClient
    }

    public func searchUsers(
        userName: String
    ) -> AnyPublisher<Users, Error> {
        networkingClient.call(
            endpoint: API.searchUsers(userName: userName)
        )
    }
}

extension SearchRepository {
    enum API {
        case searchUsers(userName: String)
    }
}

extension SearchRepository.API: APICall {
    var path: String {
        switch self {
        case let .searchUsers(userName):
            return "/search/users?q=\(userName)"
        }
    }

    var method: HTTPMethod {
        .GET
    }

    var headers: [String: String] {
        [
            HTTPHeaderField.accept.rawValue: ContentType.githubJson.rawValue,
            HTTPHeaderField.authorization.rawValue: ContentType.bearer.rawValue,
            HTTPHeaderField.version.rawValue: ContentType.version.rawValue
        ]
    }
}
