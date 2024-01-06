//
//  SearchBar.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import SwiftUI

public struct SearchBar: View {
    @Binding var searchPhrase: String
    @FocusState private var focus: Bool
    
    public init(searchPhrase: Binding<String>) {
        _searchPhrase = searchPhrase
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            TextField("Search ...", text: $searchPhrase)
                .onSubmit {
                    // self.viewModel.onSearchTap()
                }
                .keyboardType(.alphabet)
                .disableAutocorrection(true)
                .focused($focus)
        }
    }
}
