//
//  SearchServiceTests.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

@testable import GitHubBrowserNetwork
import XCTest

final class SearchServiceTests: XCTestCase {
    var service: SearchRepository!
    var mockRepository: SearchRepositoryProtocol!
    
    let users = Users(items: [
        User(id: 1,
                login: "login",
                avatarUrl: "avatarUrl",
                htmlUrl: URL(fileURLWithPath:""),
                followersUrl: URL(fileURLWithPath:""),
                followingUrl: URL(fileURLWithPath:""),
                reposUrl: URL(fileURLWithPath:"")
            ),
        User(id: 2,
                login: "login",
                avatarUrl: "avatarUrl",
             htmlUrl: URL(fileURLWithPath:""),
                followersUrl: URL(fileURLWithPath:""),
                followingUrl: URL(fileURLWithPath:""),
                reposUrl: URL(fileURLWithPath:"")
            )
        ]
    )
    
    let emptyUsers = Users(items: [])
  
    func test_searchForUserName_returnArrayOfUser() {
        let userName = "username"
        var receivedStates: [Loadable<Users, Error>] = []
        let loadable: Loadable<Users, Error> = .notRequested
        let response = LoadableSubject<Users, Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = SearchRepositoryMock()
        mockRepository.publisherToReturn = Result.success(
            users
        ).publisher.eraseToAnyPublisher()
        
        let service = SearchService(repository: mockRepository)
        
        service.searchUsers(
            userName: userName,
            response: response
        )
        
        XCTAssertEqual(mockRepository.searchUsersHasBeenCalledXTime, 1)
        XCTAssertEqual(mockRepository.searchUsersUsernameReceive, userName)
        XCTAssertEqual(receivedStates.first, .isLoading(last: nil, cancelBag: CancelBag()))
        XCTAssertEqual(receivedStates.last, .loaded(users))
    }
    
    func test_searchForUserName_returnEmptyArrayOfUser() {
        let userName = "username"
        var receivedStates: [Loadable<Users, Error>] = []
        let loadable: Loadable<Users, Error> = .notRequested
        let response = LoadableSubject<Users, Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = SearchRepositoryMock()
        mockRepository.publisherToReturn = Result.success(
            Users(
                items: []
            )
        ).publisher.eraseToAnyPublisher()
        
        let service = SearchService(repository: mockRepository)
        
        service.searchUsers(
            userName: userName,
            response: response
        )
        
        XCTAssertEqual(mockRepository.searchUsersHasBeenCalledXTime, 1)
        XCTAssertEqual(mockRepository.searchUsersUsernameReceive, userName)
        XCTAssertEqual(receivedStates.first, .isLoading(last: nil, cancelBag: CancelBag()))
        XCTAssertEqual(receivedStates.last, .loaded(emptyUsers))
    }
    
    func test_searchForUserName_returnError() {
        let userName = "username"
        var receivedStates: [Loadable<Users, Error>] = []
        let loadable: Loadable<Users, Error> = .notRequested
        let response = LoadableSubject<Users, Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = SearchRepositoryMock()
        mockRepository.publisherToReturn =  Result.failure(
            NetworkError.cantCreateURL
        ).publisher.eraseToAnyPublisher()
        
        let service = SearchService(repository: mockRepository)
        
        service.searchUsers(
            userName: userName,
            response: response
        )
        
        XCTAssertEqual(mockRepository.searchUsersHasBeenCalledXTime, 1)
        XCTAssertEqual(mockRepository.searchUsersUsernameReceive, userName)
        XCTAssertEqual(receivedStates.first, .isLoading(last: nil, cancelBag: CancelBag()))
        XCTAssertEqual(receivedStates.last, .failed(NetworkError.cantCreateURL))
    }
}
