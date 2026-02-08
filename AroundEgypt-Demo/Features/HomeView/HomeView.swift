//
//  HomeView.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel: HomeViewModelProtocol
    
    var body: some View {
        VStack {
            SearchView(searchText: $viewModel.searchText, actionOnSubmit: {
                // Search API
            })
                .padding(.horizontal)
            
            ScrollView {
                if viewModel.searchText.isEmpty {
                    WelcomeView()
                    
                    RecommendedSection(experiences: viewModel.recommendedExperiences, onHeartAction: { experience in
                        if let id = experience.id {
                            await self.viewModel.likeExperience(id: id)
                        }
                    })

                    MostRecentSection(recentExperiences: viewModel.recentExperiences, onHeartAction: { experience in
                        if let id = experience.id {
                            await self.viewModel.likeExperience(id: id)
                        }
                    })
                }
            }
            .hiddenNavigationBarStyle()
        }
        .hideKeyboardWhenTappedAround()
        .task {
            await self.viewModel.fetchData()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: MockHomeViewModel())
    }
}
