//
//  CustomAsyncImage.swift
//
//
//  Created by Franck Petriz on 06/01/2024.
//

import Foundation
import SwiftUI

struct CustomAsyncImage: View {
    private var viewModel: ViewModel
    
    init(pictureUrl: URL) {
        self.viewModel = ViewModel(
            url: pictureUrl
        )
    }
    
    var body: some View {
        AsyncImage(
            url: viewModel.url,
            transaction: Transaction(
                animation: .spring(
                    response: Constant.Transaction.response,
                    dampingFraction: Constant.Transaction.dampingFraction,
                    blendDuration: Constant.Transaction.blendDuration
                )
            )
        ) { phase in
            switch phase {
            case let .success(image):
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
    }
    
}

extension CustomAsyncImage {
    final class ViewModel {
        let url: URL
        
        init(url: URL) {
            self.url = url
        }
    }
}
