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
    
    let userArray: [User] = [
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
  
    func test_searchForUserName_returnArrayOfUser() {
        let userName = "username"
        var receivedStates: [Loadable<[User], Error>] = []
        let loadable: Loadable<[User], Error> = .notRequested
        let response = LoadableSubject<[User], Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = SearchRepositoryMock()
        mockRepository.publisherToReturn = Result.success(
            Users(
                items: userArray
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
        XCTAssertEqual(receivedStates.last, .loaded(userArray))
    }
    
    func test_searchForUserName_returnError() {
        let userName = "username"
        var receivedStates: [Loadable<[User], Error>] = []
        let loadable: Loadable<[User], Error> = .notRequested
        let response = LoadableSubject<[User], Error>(
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
