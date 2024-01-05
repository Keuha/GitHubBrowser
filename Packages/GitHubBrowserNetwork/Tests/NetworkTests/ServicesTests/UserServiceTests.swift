//
//  UserServiceTests.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

@testable import GitHubBrowserNetwork
import XCTest

final class UserServiceTests: XCTestCase {
    var service: UserService!
    var mockRepository: UserRepositoryProtocol!
    let repository = GitHubRepositoryInfo(
        id: 123,
        name: "name",
        fork: false,
        desciption: nil,
        stargazersCount: 4,
        language: nil,
        htmlUrl: URL(fileURLWithPath:"")
    )
    let userDetail = UserDetail(
        id: 132,
        login: "login",
        followers: 7,
        following: 44
    )
    
    func test_getRepositories_returnArrayOfRepository() {
        let userName = "username"
        var receivedStates: [Loadable<[GitHubRepositoryInfo], Error>] = []
        let loadable: Loadable<[GitHubRepositoryInfo], Error> = .notRequested
        let response = LoadableSubject<[GitHubRepositoryInfo], Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = UserRepositoryMock()
        mockRepository.getUserRepositoryInformationsPublisherToReturn = Result.success(
            [repository]
        ).publisher.eraseToAnyPublisher()
        
        let service = UserService(repository: mockRepository)
        
        service.getUserRepositoryInformations(
            userName: userName,
            response: response
        )
        
        XCTAssertEqual(mockRepository.getUserRepositoryInformationsHasBeenCalledXTime, 1)
        XCTAssertEqual(mockRepository.getUserRepositoryInformationsUserNameReceive, userName)
        XCTAssertEqual(receivedStates.first, .isLoading(last: nil, cancelBag: CancelBag()))
        XCTAssertEqual(receivedStates.last, .loaded([repository]))
    }
    
    func test_getRepositories_returnError() {
        let userName = "username"
        var receivedStates: [Loadable<[GitHubRepositoryInfo], Error>] = []
        let loadable: Loadable<[GitHubRepositoryInfo], Error> = .notRequested
        let response = LoadableSubject<[GitHubRepositoryInfo], Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = UserRepositoryMock()
        mockRepository.getUserRepositoryInformationsPublisherToReturn = Result.failure(
            NetworkError.cantCreateURL
        ).publisher.eraseToAnyPublisher()
        
        let service = UserService(repository: mockRepository)
        
        service.getUserRepositoryInformations(
            userName: userName,
            response: response
        )
        
        XCTAssertEqual(mockRepository.getUserRepositoryInformationsHasBeenCalledXTime, 1)
        XCTAssertEqual(mockRepository.getUserRepositoryInformationsUserNameReceive, userName)
        XCTAssertEqual(receivedStates.first, .isLoading(last: nil, cancelBag: CancelBag()))
        XCTAssertEqual(receivedStates.last, .failed(NetworkError.cantCreateURL))
    }
    
    func test_getUserDetail_returnUserDetail() {
        let userName = "username"
        var receivedStates: [Loadable<UserDetail, Error>] = []
        let loadable: Loadable<UserDetail, Error> = .notRequested
        let response = LoadableSubject<UserDetail, Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = UserRepositoryMock()
        mockRepository.getUserDetailPublisherToReturn = Result.success(
           userDetail
        ).publisher.eraseToAnyPublisher()
        
        let service = UserService(repository: mockRepository)
        
        service.getUserDetail(
            userName: userName,
            response: response
        )
        
        XCTAssertEqual(mockRepository.getUserDetailHasBeenCalledXTime, 1)
        XCTAssertEqual(mockRepository.getUserDetailUserNameReceive, userName)
        XCTAssertEqual(receivedStates.first, .isLoading(last: nil, cancelBag: CancelBag()))
        XCTAssertEqual(receivedStates.last, .loaded(userDetail))
    }
    
    func test_getUserDetails_returnError() {
        let userName = "username"
        var receivedStates: [Loadable<UserDetail, Error>] = []
        let loadable: Loadable<UserDetail, Error> = .notRequested
        let response = LoadableSubject<UserDetail, Error>(
            get: { loadable },
            set: { updatedState in receivedStates.append(updatedState) }
        )
        let mockRepository = UserRepositoryMock()
        mockRepository.getUserDetailPublisherToReturn = Result.failure(
            NetworkError.cantCreateURL
        ).publisher.eraseToAnyPublisher()
        
        let service = UserService(repository: mockRepository)
        
        service.getUserDetail(
            userName: userName,
            response: response
        )
        
        XCTAssertEqual(mockRepository.getUserDetailHasBeenCalledXTime, 1)
        XCTAssertEqual(mockRepository.getUserDetailUserNameReceive, userName)
        XCTAssertEqual(receivedStates.first, .isLoading(last: nil, cancelBag: CancelBag()))
        XCTAssertEqual(receivedStates.last, .failed(NetworkError.cantCreateURL))
    }
}
