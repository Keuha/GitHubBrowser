//
//  File.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

public protocol SearchServicing {
    func searchUsers(
        userName: String,
        response: LoadableSubject<Users, Error>
    )
}

public struct SearchService: SearchServicing {
    private let repository: SearchRepositoryProtocol
    
    public init(
        repository: SearchRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func searchUsers(
        userName: String,
        response: LoadableSubject<Users, Error>
    ) {
        let cancelBag = CancelBag()
        response.wrappedValue.setIsLoading(cancelBag: cancelBag)
        repository
            .searchUsers(userName: userName)
            .sinkToLoadable{
                response.wrappedValue = $0
            }
            .store(in: cancelBag)
    }
}

public class SearchServiceMock: SearchServicing {
    public var searchUsersHasBeenCalledXTime = 0
    public var searchUsersUserNameReceive: String!
    
    public init() { }
    
    public func searchUsers(
        userName: String,
        response: LoadableSubject<Users, Error>
    ) {
        searchUsersHasBeenCalledXTime += 1
        searchUsersUserNameReceive = userName
    }
}
