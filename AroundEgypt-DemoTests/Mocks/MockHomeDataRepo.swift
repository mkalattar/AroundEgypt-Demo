//
//  MockHomeDataRepo.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import Foundation
@testable import AroundEgypt_Demo

struct MockHomeDataRepo: AEHomeRepoProtocol {
    
    func getRecentExperiencesFromNetwork() async throws -> GetExperiencesResponse {
        return GetExperiencesResponse(meta: nil, data: MockData.makeExperiences())
    }
    
    func getRecentExperiencesFromCache() async throws -> GetExperiencesResponse {
        return GetExperiencesResponse(meta: nil, data: MockData.makeExperiences().reversed())
    }
    
    func getRecommendedExperiencesFromNetwork() async throws -> GetExperiencesResponse {
        return GetExperiencesResponse(meta: nil, data: MockData.makeExperiences())
    }
    
    func getRecommendedExperiencesFromCache() async throws -> GetExperiencesResponse {
        return GetExperiencesResponse(meta: nil, data: MockData.makeExperiences().reversed())
    }
    
    func searchExperiences(query: String) async throws -> GetExperiencesResponse {
        return GetExperiencesResponse(meta: nil, data: [])
    }
    
    func likeExperience(id: String) async throws -> Int? {
        return 0
    }
}
