//
//  AroundEgypt_DemoApp.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import SwiftUI

@main
struct AroundEgypt_DemoApp: App {
    
    @State private var homeViewModel: HomeViewModel
    
    init() {
        let cache = URLCache(memoryCapacity: 50 * 1024 * 1024,
                             diskCapacity: 100 * 1024 * 1024)
        URLCache.shared = cache
        
        let networkService: NetworkServiceProtocol = NetworkService()
        let cachingService: CacheServiceProtocol = CacheService()
        let homeRepo: AEHomeRepoProtocol = AEHomeRepo(networkService: networkService, cachingService: cachingService)
        let homeDataUseCase: GetHomeDataUseCaseProtocol = GetHomeDataUseCase(repo: homeRepo)
        let likeExperienceUseCase: LikeExperienceUseCaseProtocol = LikeExperienceUseCase(repo: homeRepo)
        let searchExperienceUseCase: SearchExperienceUseCaseProtocol = SearchExperienceUseCase(repo: homeRepo)
        
        homeViewModel = HomeViewModel(homeDataUseCase: homeDataUseCase, likeExperienceUseCase: likeExperienceUseCase, searchExperienceUseCase: searchExperienceUseCase)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(viewModel: homeViewModel)
            }
        }
    }
}
