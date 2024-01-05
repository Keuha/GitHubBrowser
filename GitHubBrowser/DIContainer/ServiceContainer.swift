//
//  ServiceContainer.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import GitHubBrowserNetwork

protocol ServiceContaining {
    var userService : UserServicing { get }
    var searchService: SearchServicing { get }
}

struct ServiceContainer : ServiceContaining {
    let userService: UserServicing
    let searchService: SearchServicing
    
    init(
        userService: UserServicing = UserService(
            repository: UserRepository(
                networkingClient: NetworkClient()
            )
        ),
        searchService: SearchServicing = SearchService(
            repository: SearchRepository(
                networkingClient: NetworkClient()
            )
        )
    ) {
        self.userService = userService
        self.searchService = searchService
    }
}
