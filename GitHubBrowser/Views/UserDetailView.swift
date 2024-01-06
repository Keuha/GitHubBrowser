//
//  UserDetailView.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 06/01/2024.
//

import SwiftUI
import GitHubBrowserUI
import GitHubBrowserNetwork

struct UserDetailView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            userInfo()
            repositoriesInfo()
        }
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func userInfo() -> some View {
        switch viewModel.userDetail {
        case let .loaded(userDetail):
            UserDetailHeader(
                viewModel: viewModel.makeUserDetailViewModel(
                    userDetail: userDetail
                )
            )
        case .failed:
            Text("Error Loading User Info")
        default:
            ProgressView()
        }
    }
    
    @ViewBuilder
    func repositoriesInfo() -> some View {
        switch viewModel.repositoriesInfo {
        case let .loaded(repositories):
            ForEach(repositories) { repository in
                RepositoryRow(viewModel: viewModel.makeRepositoryRowViewModel(repository: repository))
            }
        case .failed:
            Text("Error Loading Repositories Info")
        default:
            ProgressView()
        }
    }
}

extension UserDetailView {
    final class ViewModel: ObservableObject, Navigable {
        private let container: DIContainer
        let userName: String
        let profilePicture: URL
        @Published var userDetail: Loadable<UserDetail, Error> = .notRequested
        @Published var repositoriesInfo: Loadable<[GitHubRepositoryInfo], Error> = .notRequested
        
        init(
            container: DIContainer,
            userName: String,
            profilePicture: URL
        ) {
            self.container = container
            self.userName = userName
            self.profilePicture = profilePicture
            fetchInitialData()
        }
        
        func makeUserDetailViewModel(userDetail: UserDetail) -> UserDetailHeader.ViewModel {
            .init(
                login: userDetail.login,
                name: userDetail.name,
                followers: userDetail.followers,
                following: userDetail.following,
                profilePicture: self.profilePicture
            )
        }
        
        func makeRepositoryRowViewModel(repository: GitHubRepositoryInfo) -> RepositoryRow.ViewModel {
            .init(
                name: repository.name,
                description: repository.description,
                starCount: repository.stargazersCount,
                language: repository.language,
                htmlUrl: repository.htmlUrl
            )
        }
    }
}

private extension UserDetailView.ViewModel {
    func fetchInitialData() {
        container
            .service
            .userService
            .getUserDetail(
                userName: userName,
                response: loadableSubject(\.userDetail)
            )
        container
            .service
            .userService
            .getUserRepositoryInformations(
                userName: userName,
                response: loadableSubject(\.repositoriesInfo)
            )
    }
}
