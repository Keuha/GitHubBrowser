//
//  UserRepository.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine

public protocol UserRepositoryProtocol {
    func getUserRepositoryInformations(userName: String) -> AnyPublisher<[GitHubRepositoryInfo], Error>
    func getUserDetail(userName: String) -> AnyPublisher<UserDetail, Error>
}

public struct UserRepository: UserRepositoryProtocol {
    private let networkingClient: NetworkingClientProtocol
    
    public init(
        networkingClient: NetworkingClientProtocol
    ) {
        self.networkingClient = networkingClient
    }
    
    public func getUserRepositoryInformations(
        userName: String
    ) -> AnyPublisher<[GitHubRepositoryInfo], Error> {
        networkingClient.call(
            endpoint: API.getUserRepositoryInformations(userName: userName)
        )
    }
    
    public func getUserDetail(
        userName: String
    ) -> AnyPublisher<UserDetail, Error>  {
        networkingClient.call(
            endpoint: API.getUserDetail(userName: userName)
        )
    }
}

extension UserRepository {
    enum API {
        case getUserRepositoryInformations(userName: String)
        case getUserDetail(userName: String)
    }
}

extension UserRepository.API: APICall {

    var path: String {
        switch self {
        case let .getUserDetail(userName):
            return "/users/\(userName)"
        case .getUserRepositoryInformations(userName: let userName):
            return "/users/\(userName)/repos"
        }
    }

    var method: HTTPMethod {
        .GET
    }

    var headers: [String: String] {
        [
            HTTPHeaderField.accept.rawValue: ContentType.githubJson.rawValue,
//            HTTPHeaderField.authorization.rawValue: ContentType.bearer.rawValue,
            HTTPHeaderField.version.rawValue: ContentType.version.rawValue
        ]
    }
}
