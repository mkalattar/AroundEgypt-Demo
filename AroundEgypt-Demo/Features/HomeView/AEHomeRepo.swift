//
//  AEHomeRepo.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import Foundation

protocol AEHomeRepoProtocol: Sendable {
    func getRecentExperiencesFromNetwork() async throws -> GetExperiencesResponse
    func getRecentExperiencesFromCache() async throws -> GetExperiencesResponse
    
    func getRecommendedExperiencesFromNetwork() async throws -> GetExperiencesResponse
    func getRecommndedExperiencesFromCache() async throws -> GetExperiencesResponse
    
    func searchExperiences(query: String) async throws -> GetExperiencesResponse
    func likeExperience(id: String) async throws -> Int?
}

actor AEHomeRepo: AEHomeRepoProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let cachingService: CacheServiceProtocol
    private let userDefaults: UserDefaults
    
    private var likedExpIDs: Set<String> = []
    
    init(networkService: NetworkServiceProtocol, cachingService: CacheServiceProtocol, userDefaults: UserDefaults = .standard) async {
        self.networkService = networkService
        self.cachingService = cachingService
        self.userDefaults = userDefaults
        
        likedExpIDs = loadLikedIds()
    }
    
    func getRecentExperiencesFromNetwork() async throws -> GetExperiencesResponse {
        var response: GetExperiencesResponse = try await networkService.fetch(from: .recentExperiences)
        
        response.data = self.applyLocalLikes(to: response.data ?? [])
        
        try await cachingService.save(response.data, forKey: "recent_exp")
        return response
    }
    
    func getRecentExperiencesFromCache() async throws -> GetExperiencesResponse {
        var experiences: [Experience]? = try await cachingService.load(forKey: "recent_exp")
        
        guard var experiences else {
            throw AENetworkError.noInternetConnection
        }
        
        experiences = self.applyLocalLikes(to: experiences)
        
        return GetExperiencesResponse(meta: nil, data: experiences)
    }
    
    func getRecommendedExperiencesFromNetwork() async throws -> GetExperiencesResponse {
        let response: GetExperiencesResponse = try await networkService.fetch(from: .recommendedExperiences)
        try await cachingService.save(response.data, forKey: "recommended_exp")
        return response
    }
    
    func getRecommndedExperiencesFromCache() async throws -> GetExperiencesResponse {
        let experiences: [Experience]? = try await cachingService.load(forKey: "recommended_exp")
        
        guard let experiences else {
            throw AENetworkError.noInternetConnection
        }
        
        return GetExperiencesResponse(meta: nil, data: experiences)
    }
    
    func searchExperiences(query: String) async throws -> GetExperiencesResponse {
        let response: GetExperiencesResponse = try await networkService.fetch(from: .search(query: query))
        return response
    }
    
    func likeExperience(id: String) async throws -> Int? {
        
        if likedExpIDs.contains(id) {
            throw AEAppError.alreadyLiked
        }
        
        let response: PostLikeExperienceResponse = try await networkService.fetch(from: .likeExperience(id: id))
        
        likedExpIDs.insert(id)
        self.saveLikedIds()
        
        var recentExp: [Experience] = try await cachingService.load(forKey: "recent_exp") ?? []
        var recommendedExp: [Experience] = try await cachingService.load(forKey: "recommended_exp") ?? []
        
        var cacheWasUpdated = false
        
        if let index = recentExp.firstIndex(where: { $0.id == id }) {
            recentExp[index].likesNo = response.data
            
            cacheWasUpdated = true
        }
        
        if let index = recommendedExp.firstIndex(where: { $0.id == id }) {
            recommendedExp[index].likesNo = response.data
            cacheWasUpdated = true
        }
        
        if cacheWasUpdated {
            try await cachingService.save(recommendedExp, forKey: "recommended_exp")
            try await cachingService.save(recentExp, forKey: "recent_exp")
        }
        
        return response.data
    }
    
    private func applyLocalLikes(to experiences: [Experience]) -> [Experience] {
        return experiences.map { experience in
            var mutableExperience = experience
            if likedExpIDs.contains(experience.id ?? "") {
                mutableExperience.isLiked = true
            }
            return mutableExperience
        }
    }
    
    private func loadLikedIds() -> Set<String> {
        guard let data = userDefaults.data(forKey: "likedIds"), let ids = try? JSONDecoder().decode(Set<String>.self, from: data) else {
            return []
        }
        return ids
    }
    
    private func saveLikedIds() {
        if let data = try? JSONEncoder().encode(likedExpIDs) {
            userDefaults.set(data, forKey: "likedIds")
        }
    }
}
