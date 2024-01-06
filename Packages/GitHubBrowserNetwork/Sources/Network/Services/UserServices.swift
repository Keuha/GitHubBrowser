//
//  UserServices.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

public protocol UserServicing {
    func getUserRepositoryInformations(
        userName: String,
        response: LoadableSubject<[GitHubRepositoryInfo], Error>
    )
    
    func getUserDetail(
        userName: String,
        response: LoadableSubject<UserDetail, Error>
    )
}

public struct UserService: UserServicing {
    private let repository: UserRepositoryProtocol
    
    public init(
        repository: UserRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func getUserRepositoryInformations(
        userName: String,
        response: LoadableSubject<[GitHubRepositoryInfo], Error>
    ) {
        let cancelBag = CancelBag()
        response.wrappedValue.setIsLoading(cancelBag: cancelBag)
        repository
            .getUserRepositoryInformations(userName: userName)
            .sinkToLoadable{
                response.wrappedValue = $0.map {
                    $0.filter { $0.fork == false }
                }
            }
            .store(in: cancelBag)
    }
    
    public func getUserDetail(
        userName: String,
        response: LoadableSubject<UserDetail, Error>
    ) {
        let cancelBag = CancelBag()
        response.wrappedValue.setIsLoading(cancelBag: cancelBag)
        repository
            .getUserDetail(userName: userName)
            .sinkToLoadable {
                response.wrappedValue = $0
            }
            .store(in: cancelBag)
    }
}

public class UserServiceMock: UserServicing {
    public var getUserRepositoryInformationsHasBeenCalledXTime = 0
    public var getUserRepositoryInformationsUserNameReceive: String!
   
    public var getUserDetailHasBeenCalledXTime = 0
    public var getUserDetailUserNameReceive: String!
    
    public init() { }
    
    public func getUserRepositoryInformations(
        userName: String,
        response: LoadableSubject<[GitHubRepositoryInfo], Error>
    ) {
        getUserRepositoryInformationsHasBeenCalledXTime += 1
        getUserRepositoryInformationsUserNameReceive = userName
    }
    
    public func getUserDetail(
        userName: String,
        response: LoadableSubject<UserDetail, Error>
    ) {
        getUserDetailHasBeenCalledXTime += 1
        getUserDetailUserNameReceive = userName
    }
}
