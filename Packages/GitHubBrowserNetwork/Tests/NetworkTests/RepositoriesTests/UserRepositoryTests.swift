//
//  UserRepositoryTests.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

@testable import GitHubBrowserNetwork
import XCTest

final class UserRepositoryTests: XCTestCase {
    
    func test_getUserRepositoryInformations_returnExpectedEndPoint() {
        let networkClientMock = NetworkClientMock()
        let userName = "userName to find back"
        
        let sut = UserRepository(networkingClient: networkClientMock)
        _ = sut.getUserRepositoryInformations(userName: userName)
        
        XCTAssertEqual(networkClientMock.callHasBennCalledXTime, 1)
        XCTAssertEqual(networkClientMock.callEndpointReceive!.path, "/users/\(userName)/repos")
        XCTAssertEqual(networkClientMock.callEndpointReceive!.method, HTTPMethod.GET)
    }
    
    func test_getUserDetail_returnExpectedEndPoint() {
        let networkClientMock = NetworkClientMock()
        let userName = "userName to find back"
        
        let sut = UserRepository(networkingClient: networkClientMock)
        _ = sut.getUserDetail(userName: userName)
        
        XCTAssertEqual(networkClientMock.callHasBennCalledXTime, 1)
        XCTAssertEqual(networkClientMock.callEndpointReceive!.path, "/users/\(userName)")
        XCTAssertEqual(networkClientMock.callEndpointReceive!.method, HTTPMethod.GET)
    }
}
