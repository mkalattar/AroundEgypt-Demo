//
//  SearchView.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    var actionOnSubmit: () -> Void = {}

    var body: some View {
        HStack {
            Button {}
            label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 11)
                    .foregroundStyle(.black)
            }

            SearchTextField(searchText: $searchText, actionOnSubmit: actionOnSubmit)
            
            Button {}
            label: {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 14)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
