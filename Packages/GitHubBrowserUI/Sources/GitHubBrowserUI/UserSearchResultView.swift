//
//  UserSearchResultView.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import SwiftUI

public struct UserSearchResultView: View {
    private var viewModel: UserSearchResultView.ViewModel
    
    public init(
        viewModel: UserSearchResultView.ViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        HStack {
            AsyncImage(url: viewModel.profilePicture,
                       transaction: Transaction(
                                  animation: .spring(
                                    response: Constant.Transaction.response,
                                      dampingFraction: Constant.Transaction.dampingFraction,
                                      blendDuration: Constant.Transaction.blendDuration)
                              )
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .transition(.scale)
                        .padding()
                case .failure:
                    Image(systemName: "ant.circle.fill")
                        .scaledToFit()
                        .frame(maxWidth: Constant.Sizing.pictureMaxWidth)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                        .padding()
                case .empty:
                    Image(systemName: "photo.circle.fill")
                        .scaledToFit()
                        .frame(maxWidth: Constant.Sizing.pictureMaxWidth)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                        .padding()
                @unknown default:
                    ProgressView()
                }
            }
            .padding(.horizontal)
            Spacer()
            Text(viewModel.userName)
            Image(systemName: "chevron.right")
                .frame(maxWidth: Constant.Sizing.pictureMaxWidth)
                .foregroundColor(.black)
                .padding(.trailing)
            
        }
        .frame(
            maxWidth: .infinity,
            minHeight: Constant.Row.minHeight,
            maxHeight: Constant.Row.maxHeight
        )
        .background(.teal)
        .cornerRadius(Constant.Radius.small)
        .padding(.horizontal)
        
    }
}

public extension UserSearchResultView {
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
    UserSearchResultView(
        viewModel: UserSearchResultView.ViewModel(
            profilePicture: URL(string: "https://avatars.githubusercontent.com/u/3855308?v=4")!,
            userName: "Keuha"
        )
    )
}
