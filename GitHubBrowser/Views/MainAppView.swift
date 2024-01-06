//
//  MainAppView.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 06/01/2024.
//

import GitHubBrowserNetwork
import SwiftUI

struct MainAppView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationStep) {
            VStack {
                rootView()
            }
            .navigationDestination(for: NavigationFlowSteps.self) { step in
                VStack {
                    switch step {
                    case let .userDetailView(viewModel):
                        UserDetailView(viewModel: viewModel)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func rootView() -> some View {
        SearchUserView(viewModel: viewModel.makeSearchUserViewModel())
    }
}

extension MainAppView {
    final class ViewModel: ObservableObject {
        @Published var navigationStep: [NavigationFlowSteps] = []
        private var cancelBag = CancelBag()
        private let container: DIContainer
        
        init(
            container: DIContainer
        ) {
            self.container = container
        }
        
        func makeSearchUserViewModel() -> SearchUserView.ViewModel {
            let viewModel = SearchUserView.ViewModel(
                container: container
            )
            viewModel.didComplete
                .sink(receiveValue: navigateToUserDetail)
                .store(in: cancelBag)
            return viewModel
        }
        
        func navigateToUserDetail(user: User) {
            let viewModel = UserDetailView.ViewModel(
                container: container,
                userName: user.login,
                profilePicture: user.avatarUrl
            )
            navigationStep.append(.userDetailView(viewModel: viewModel))
        }
    }
}
