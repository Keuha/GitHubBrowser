//
//  NavigationFlow.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 06/01/2024.
//

import Foundation

enum NavigationFlowSteps: Hashable, Equatable {
    case userDetailView(viewModel: UserDetailView.ViewModel)
    
    var viewModel: any ObservableObject {
        switch self {
        case let .userDetailView(viewModel):
            return viewModel
        }
    }
}

protocol Navigable: AnyObject, Identifiable, Hashable {}

extension Navigable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
