//
//  SearchRepositoryTests.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

@testable import GitHubBrowserNetwork
import XCTest

final class SearchRepositoryTests: XCTestCase {
    
    func test_searchingForUser_returnExpectedEndPoint() {
        let networkClientMock = NetworkClientMock()
        let userName = "userName to find back"
        
        let sut = SearchRepository(networkingClient: networkClientMock)
        _ = sut.searchUsers(userName: userName)
        
        XCTAssertEqual(networkClientMock.callHasBennCalledXTime, 1)
        XCTAssertEqual(networkClientMock.callEndpointReceive!.path, "/search/users?q=\(userName)")
        XCTAssertEqual(networkClientMock.callEndpointReceive!.method, HTTPMethod.GET)
    }
}
