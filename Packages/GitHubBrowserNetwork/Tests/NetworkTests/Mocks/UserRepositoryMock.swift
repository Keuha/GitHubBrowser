//
//  File.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import Combine
@testable import GitHubBrowserNetwork

final class UserRepositoryMock: UserRepositoryProtocol {
    var getUserRepositoryInformationsHasBeenCalledXTime = 0
    var getUserRepositoryInformationsUserNameReceive: String!
    var getUserRepositoryInformationsPublisherToReturn: AnyPublisher<[GitHubRepositoryInfo], Error>!
    
    var getUserDetailHasBeenCalledXTime = 0
    var getUserDetailUserNameReceive: String!
    var getUserDetailPublisherToReturn: AnyPublisher<UserDetail, Error>!
    
    
    func getUserRepositoryInformations(userName: String) -> AnyPublisher<[GitHubBrowserNetwork.GitHubRepositoryInfo], Error> {
        getUserRepositoryInformationsHasBeenCalledXTime += 1
        getUserRepositoryInformationsUserNameReceive = userName
        return getUserRepositoryInformationsPublisherToReturn
    }
    
    func getUserDetail(userName: String) -> AnyPublisher<GitHubBrowserNetwork.UserDetail, Error> {
        getUserDetailHasBeenCalledXTime += 1
        getUserDetailUserNameReceive = userName
        return getUserDetailPublisherToReturn
    }
}
