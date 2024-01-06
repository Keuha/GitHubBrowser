//
//  RepositoryRow.swift
//
//
//  Created by Franck Petriz on 06/01/2024.
//

import SwiftUI

public struct RepositoryRow: View {
    private let viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                name
                    .padding([.horizontal, .top])
                HStack {
                    stars
                    language
                }
                .frame(
                    maxWidth: .infinity,
                    minHeight: Constant.Row.minHeight,
                    maxHeight: Constant.Row.maxHeight
                )
                .padding(.horizontal)
                HStack {
                    Text(viewModel.description)
                }
                .padding([.horizontal, .bottom])
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
    
    
    private var name: some View {
        Text(viewModel.name)
            .bold()
    }
   
    private var stars: some View {
        HStack {
            Image(systemName: "star.fill")
                .frame(
                    width: Constant.Icons.size,
                    height: Constant.Icons.size
                )
            Text("\(viewModel.starCount)")
        }
    }
    
    private var language: some View {
        Text(viewModel.language)
            .italic()
    }
}

public extension RepositoryRow {
    final class ViewModel {
        let name: String
        let description: String
        let starCount: Int
        let language: String
        let htmlUrl: URL
        let onUrlTap: (() -> Void)?
        
        public init(
            name: String,
            description: String?,
            starCount: Int,
            language: String?,
            htmlUrl: URL,
            onUrlTap: (() -> Void)? = nil
        ) {
            self.name = name
            self.description = description ?? ""
            self.starCount = starCount
            self.language = language ?? ""
            self.htmlUrl = htmlUrl
            self.onUrlTap = onUrlTap
        }
    }
}
