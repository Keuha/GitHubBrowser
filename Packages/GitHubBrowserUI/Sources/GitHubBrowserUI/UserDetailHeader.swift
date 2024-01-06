//
//  UserDetailHeader.swift
//
//
//  Created by Franck Petriz on 06/01/2024.
//

import Foundation
import SwiftUI

public struct UserDetailHeader: View {
    private var viewModel: ViewModel
    
    public init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            HStack {
                CustomAsyncImage(pictureUrl: viewModel.profilePicture)
                    .padding(.horizontal)
                VStack {
                    Text("@\(viewModel.login)")
                        .italic()
                    Text(viewModel.name)
                        .bold()
                }
                .padding(.horizontal)
            }
            .frame(
                maxWidth: .infinity,
                minHeight: Constant.Row.minHeight,
                maxHeight: Constant.Row.maxHeight
            )
            HStack {
                Text(viewModel.followers)
                Text(viewModel.following)
            }
            .padding([.leading, .trailing, .bottom])
        }
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

public extension UserDetailHeader {
    final class ViewModel {
        let login: String
        let name: String
        let followers: String
        let following: String
        let profilePicture: URL
        
        public init(
            login: String,
            name: String,
            followers: String,
            following: String,
            profilePicture: URL
        ) {
            self.login = login
            self.name = name
            self.followers = followers
            self.following = following
            self.profilePicture = profilePicture
        }
    }
    
}
