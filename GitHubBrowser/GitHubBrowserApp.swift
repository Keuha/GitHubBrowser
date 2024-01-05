//
//  GitHubBrowserApp.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 05/01/2024.
//

import SwiftUI
import GitHubBrowserNetwork

@main
struct GitHubBrowserApp: App {
    let container = Container(service: ServiceContainer())
    var body: some Scene {
        WindowGroup {
            MainAppView(
                viewModel: .init(
                    container: container
                )
            )
        }
    }
}
