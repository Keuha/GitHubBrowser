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
                Text("Followers : \(viewModel.followers)")
                Text("Following : \(viewModel.following)")
            }
            .padding([.leading, .trailing, .bottom])
        }
        .overlay(
            RoundedRectangle(cornerRadius: Constant.Radius.small)
                .stroke(
                    .gray,
                    lineWidth: 1
                )
            )
        .padding(.horizontal)
    }
}

public extension UserDetailHeader {
    final class ViewModel {
        let login: String
        let name: String
        let followers: Int
        let following: Int
        let profilePicture: URL
        
        public init(
            login: String,
            name: String,
            followers: Int,
            following: Int,
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
