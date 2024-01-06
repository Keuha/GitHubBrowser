//
//  SearchUserView.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 05/01/2024.
//

import SwiftUI
import GitHubBrowserNetwork
import GitHubBrowserUI
import Combine

struct SearchUserView: View {
    @StateObject var viewModel: SearchUserView.ViewModel
    
    var body: some View {
        VStack(alignment: .center) {
                loading()
                content()
            }
            .searchable(text: $viewModel.searchTerm)
            .padding()
            .navigationTitle("Search for github user")
    }
    
    @ViewBuilder
    func content() -> some View {
        switch viewModel.users {
        case .notRequested:
            emptyResult()
        case .isLoading,
                .loaded:
            userRow()
        case .failed:
           errorView()
        }
    }
    
    @ViewBuilder
    func userRow() -> some View {
        if let value = viewModel.getUsers(),
           value.items.isEmpty == false {
            // some values are available to display
            ScrollView {
                ForEach(
                    value.items
                ) { user in
                    UserSearchResultView(
                        viewModel: UserSearchResultView.ViewModel(
                            profilePicture: URL(string: user.avatarUrl)!,
                            userName: user.login
                        )
                    ).onTapGesture {
                        viewModel.didComplete.send(user.login)
                    }
                }
            }
        } else {
            // no result
            emptyResult()
        }
    }
    
    @ViewBuilder
    func emptyResult() -> some View {
        if viewModel.searchTerm.isEmpty {
            // No Search terms has been input, display a welcome message
            Spacer()
            Text("Go look for something!")
            Spacer()
        } else if viewModel.lastSearchedTerm.isEmpty == false && viewModel.users.isLoading == false {
            // a term has been searched, and the view is not loading anymore, it means no result have been fetched
            Spacer()
            Text("No result for \(viewModel.lastSearchedTerm)")
            Spacer()
        } else {
            // loading
            Spacer()
        }
            
    }
    
    @ViewBuilder
    func loading() -> some View {
        if viewModel.users.isLoading {
            ProgressView()
                .padding()
        } else {
            EmptyView()
        }
    }
    
    func errorView() -> some View {
        VStack {
            Text("looks like we encoutered an issue !")
            if let error = viewModel.users.error {
                Text(error.localizedDescription)
            }
        }
    }
                    
}

extension SearchUserView {
    final class ViewModel: ObservableObject, Navigable {
        private let container: DIContainer
        private var cancelBag = CancelBag()
        @Published var searchTerm: String = ""
        @Published var users: Loadable<Users, Error> = .notRequested
        @Published private(set) var lastSearchedTerm: String = ""
        var didComplete = PassthroughSubject<String, Never>()
        private var timer: Timer?
       
        init(
            container: DIContainer
        ) {
            self.container = container
            listenToSearchTermChange()
        }
        
        func getUsers() -> Users? {
            switch users {
            case let .isLoading(last: users, _):
                return users
            case let .loaded(users):
                return users
            default:
                return nil
            }
        }
        static func == (lhs: SearchUserView.ViewModel, rhs: SearchUserView.ViewModel) -> Bool {
            lhs.users == rhs.users &&
            lhs.searchTerm == rhs.searchTerm
        }
    }
}

private extension SearchUserView.ViewModel {
    func request() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { timer in
            timer.invalidate()
            self.container
                .service
                .searchService
                .searchUsers(
                    userName: self.searchTerm,
                    response: self.loadableSubject(\.users)
                )
            self.lastSearchedTerm = self.searchTerm
        }
    }
   
    func listenToSearchTermChange() {
        $searchTerm.sink { value in
            if value.isEmpty == false {
                self.request()
            }
        }
        .store(in: cancelBag)
    }
}
