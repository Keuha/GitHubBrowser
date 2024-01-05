//
//  SearchRepositoryMock.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine
@testable import GitHubBrowserNetwork

final class SearchRepositoryMock: SearchRepositoryProtocol {
    var searchUsersUsernameReceive: String!
    var searchUsersHasBeenCalledXTime = 0
    var publisherToReturn: AnyPublisher<Users, Error>!
    
    func searchUsers(userName: String) -> AnyPublisher<Users, Error> {
        searchUsersHasBeenCalledXTime += 1
        searchUsersUsernameReceive = userName
        return publisherToReturn
    }
}
