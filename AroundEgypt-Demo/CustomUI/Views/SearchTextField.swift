//
//  SearchView.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var searchText: String
    var actionOnSubmit: () -> Void = {}
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Try \"Luxor\" ", text: $searchText)
                .submitLabel( searchText.isEmpty ? .return : .search)
                .onSubmit(actionOnSubmit)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    SearchTextField(searchText: .constant(""))
}
