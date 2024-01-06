//
//  UserDetailView.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 06/01/2024.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text("UserDetailView for \(viewModel.userName)")
    }
}

extension UserDetailView {
    final class ViewModel: ObservableObject, Navigable {
        private let container: DIContainer
        let userName: String
        
        init(
            container: DIContainer,
            userName: String
        ) {
            self.container = container
            self.userName = userName
        }
    }
}
