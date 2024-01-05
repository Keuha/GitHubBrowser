//
//  Container.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

protocol DIContainer {
    var service: ServiceContaining { get }
}

struct Container: DIContainer {
    let service: ServiceContaining
    
    init(
        service: ServiceContaining = ServiceContainer()
    ) {
        self.service = service
    }
}
