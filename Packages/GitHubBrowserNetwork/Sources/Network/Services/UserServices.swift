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
                response.wrappedValue = $0
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
