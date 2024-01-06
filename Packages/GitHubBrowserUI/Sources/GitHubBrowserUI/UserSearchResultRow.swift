//
//  UserSearchResultRow.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import SwiftUI

public struct UserSearchResultRow: View {
    private var viewModel: UserSearchResultRow.ViewModel
    
    public init(
        viewModel: UserSearchResultRow.ViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        HStack {
            CustomAsyncImage(pictureUrl: viewModel.profilePicture)
                .padding(.horizontal)
            Spacer()
            Text(viewModel.userName)
            Image(systemName: "chevron.right")
                .frame(maxWidth: Constant.Sizing.pictureMaxWidth)
                .padding(.trailing)
            
        }
        .frame(
            maxWidth: .infinity,
            minHeight: Constant.Row.minHeight,
            maxHeight: Constant.Row.maxHeight
        )
        .cornerRadius(Constant.Radius.small)
        .overlay(
            RoundedRectangle(cornerRadius: Constant.Radius.small)
            .stroke(
                Color.cardBackground.opacity(0.3),
                lineWidth: 1
            )
            .background(
                RoundedRectangle(cornerRadius: Constant.Radius.small)
                    .fill(Color.gray.opacity(0.1))
            )
        )
        .padding(.horizontal)
    }
}

public extension UserSearchResultRow {
    class ViewModel {
        let profilePicture: URL
        let userName: String
        
        public init(
            profilePicture: URL,
            userName: String
        ) {
            self.profilePicture = profilePicture
            self.userName = userName
        }
    }
}

#Preview {
    UserSearchResultRow(
        viewModel: UserSearchResultRow.ViewModel(
            profilePicture: URL(string: "https://avatars.githubusercontent.com/u/3855308?v=4")!,
            userName: "Keuha"
        )
    )
}
