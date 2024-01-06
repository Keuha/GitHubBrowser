//
//  UserDetailViewModel.swift
//  GitHubBrowserTests
//
//  Created by Franck Petriz on 06/01/2024.
//

import XCTest
import GitHubBrowserNetwork
import GitHubBrowserUI
@testable import GitHubBrowser

final class UserDetailViewModel: XCTestCase {

    func test_whenInitaitingViewModel_RequestArePerformed() {
        let userName = "Test"
        let mockUserService = UserServiceMock()
        let mockSearchService = SearchServiceMock()
        let mockService = ServiceContainerMock(
            userService: mockUserService,
            searchService: mockSearchService
        )
        let mockContainer = ContainerMock(service: mockService)
        _ = UserDetailView.ViewModel(
            container: mockContainer,
            userName: userName,
            profilePicture: URL(fileURLWithPath: "")
        )
       
        XCTAssertEqual(mockUserService.getUserDetailHasBeenCalledXTime, 1)
        XCTAssertEqual(mockUserService.getUserDetailUserNameReceive, userName)
        
        XCTAssertEqual(mockUserService.getUserRepositoryInformationsHasBeenCalledXTime, 1)
        XCTAssertEqual(mockUserService.getUserRepositoryInformationsUserNameReceive, userName)
        
        XCTAssertEqual(mockSearchService.searchUsersHasBeenCalledXTime, 0)
    }
}
