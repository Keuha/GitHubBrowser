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
        response: LoadableSubject<[User], Error>
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
        response: LoadableSubject<[User], Error>
    ) {
        let cancelBag = CancelBag()
        response.wrappedValue.setIsLoading(cancelBag: cancelBag)
        repository
            .searchUsers(userName: userName)
            .sinkToLoadable{
                response.wrappedValue = $0.map(\.items)
            }
            .store(in: cancelBag)
    }
}
