//
//  MainAppView.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 05/01/2024.
//

import SwiftUI
import GitHubBrowserNetwork
import Combine

struct MainAppView: View {
    @StateObject var viewModel: MainAppView.ViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            viewModel.request()
        }
    }
}

extension MainAppView {
    final class ViewModel: ObservableObject {
        private let container: DIContainer
        private var cancelBag = CancelBag()
        @Published var users: Loadable<[User], Error> = .notRequested
        @Published var userDetails: Loadable<UserDetail, Error> = .notRequested
        @Published var repositoryInfo: Loadable<[GitHubRepositoryInfo], Error> = .notRequested
        
        init(
            container: DIContainer
            
        ) {
            self.container = container
            listenToUsersChange()
            listenToUserDetailChange()
            listenToRepositoryInfoUpdate()
        }
        
        func request() {
//            container
//                .service
//                .searchService
//                .searchUsers(
//                    userName: "Keuha",
//                    response: loadableSubject(\.users)
//                )
//            container
//                .service
//                .userService
//                .getUserDetail(
//                    userName: "Keuha",
//                    response: loadableSubject(\.userDetails)
//                )
            container
                .service
                .userService
                .getUserRepositoryInformations(
                    userName: "Keuha",
                    response: loadableSubject(\.repositoryInfo)
                )
        }
    }
}

private extension MainAppView.ViewModel {
    func listenToUsersChange() {
        $users.sink { result in
            switch result {
            case .notRequested:
                print("notRequested")
            case .isLoading:
                print("isLoading")
            case .loaded:
                print("loaded")
            case let .failed(error):
                print("failed", error)
            }
        }.store(in: cancelBag)
    }
    
    func listenToUserDetailChange() {
        $userDetails.sink { result in
            switch result {
            case .notRequested:
                print("$userDetails notRequested")
            case .isLoading:
                print("$userDetails isLoading")
            case .loaded:
                print("$userDetails loaded")
            case let .failed(error):
                print("$userDetails failed", error)
            }
        }.store(in: cancelBag)
    }
    
    func listenToRepositoryInfoUpdate() {
        $repositoryInfo.sink { result in
            switch result {
            case .notRequested:
                print("$$repositoryInfo notRequested")
            case .isLoading:
                print("$$repositoryInfo isLoading")
            case .loaded:
                print("$$repositoryInfo loaded")
            case let .failed(error):
                print("$$repositoryInfo failed", error)
            }
        }.store(in: cancelBag)
    }
}
