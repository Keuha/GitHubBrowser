//
//  ContainerMock.swift
//  GitHubBrowserTests
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import GitHubBrowserNetwork
@testable import GitHubBrowser

class ContainerMock: DIContainer {
    var service: GitHubBrowser.ServiceContaining
    
    init(service: ServiceContaining = ServiceContainerMock()) {
        self.service = service
    }
}

class ServiceContainerMock: ServiceContaining {
    var userService: UserServicing
    var searchService: SearchServicing
    
    init(
        userService: UserServicing = UserServiceMock(),
        searchService: SearchServicing = SearchServiceMock()
    ) {
        self.userService = userService
        self.searchService = searchService
    }
}
