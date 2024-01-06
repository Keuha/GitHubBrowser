//
//  MainAppViewModelTests.swift
//  GitHubBrowserTests
//
//  Created by Franck Petriz on 05/01/2024.
//

import XCTest
import GitHubBrowserNetwork
@testable import GitHubBrowser

final class MainAppViewModelTests: XCTestCase {

    func test_whenSearchTermChangeMultipleTime_onlyOnerequestIsMade() {
        let mockSearchService = SearchServiceMock()
        let mockService = ServiceContainerMock(
            searchService: mockSearchService
        )
        let mockContainer = ContainerMock(service: mockService)
        let sut = SearchUserView.ViewModel(container: mockContainer)
        
        sut.searchTerm = "123"
        sut.searchTerm = "1234"
        sut.searchTerm = "12345"
        sut.searchTerm = "123456"
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(mockSearchService.searchUsersHasBeenCalledXTime, 1)
            XCTAssertEqual(mockSearchService.searchUsersUserNameReceive, "123456")
        }
    }
    
    func test_whenUsersHasntLoadPriorValue_getUserIsNil() {
        let mockSearchService = SearchServiceMock()
        let mockService = ServiceContainerMock(
            searchService: mockSearchService
        )
        let mockContainer = ContainerMock(service: mockService)
        let sut = SearchUserView.ViewModel(container: mockContainer)
        
        XCTAssertNil(sut.getUsers())
    }
    
    func test_whenUsersHasLoadPriorValue_usersIsLoading_getUserIsNotNil() {
        let mockContainer = ContainerMock()
        let sut = SearchUserView.ViewModel(container: mockContainer)
        
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
        
        sut.users = .isLoading(last: users, cancelBag: CancelBag())
        
        XCTAssertEqual(sut.getUsers(), users)
    }
    
    func test_whenUsersHasLoadPriorValue_usersIsLoadingButPreviousIsNil_getUserIsNil() {
        let mockContainer = ContainerMock()
        let sut = SearchUserView.ViewModel(container: mockContainer)
        
        sut.users = .isLoading(last: nil, cancelBag: CancelBag())
        
        XCTAssertNil(sut.getUsers())
    }
}
