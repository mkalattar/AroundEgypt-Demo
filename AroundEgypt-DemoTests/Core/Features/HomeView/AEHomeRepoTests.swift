//
//  AEHomeRepoTests.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import Foundation
import Testing
@testable import AroundEgypt_Demo

struct AEHomeRepoTests {
    
    @Test("Test Repo saves to cache")
    func testRepoSavesToCache() async throws {
        let userDefault = UserDefaults(suiteName: #file)!
        
        defer {
            userDefault.removePersistentDomain(forName: #file)
        }
        
        let expectedResponse = GetExperiencesResponse(meta: nil, data: MockData.makeExperiences())
        let jsonData = try JSONEncoder().encode(expectedResponse)
        let mockSession = MockData.makeMockSession(data: jsonData)
        let mockCache = MockCacheService()
        
        let repo = await AEHomeRepo(networkService: NetworkService(session: mockSession),
                                    cachingService: mockCache,
                                    userDefaults: userDefault)
        
        _ = try await repo.getRecentExperiencesFromNetwork()
        
        let cachedItem: [Experience]? = try await mockCache.load(forKey: "recent_exp")
        let repoCachedItems: GetExperiencesResponse = try await repo.getRecentExperiencesFromCache()
        
        #expect(cachedItem?.count == expectedResponse.data?.count)
        #expect(cachedItem?.first?.id == expectedResponse.data?.first?.id)
        #expect(cachedItem?.count == repoCachedItems.data?.count)
    }
    
    @Test("Testing likes")
    func testLike() async throws {
        let suiteName = "testing_suite"
        let userDefault = UserDefaults(suiteName: suiteName)!
        
        defer {
            userDefault.removePersistentDomain(forName: suiteName)
        }
        
        let expectedLikeResponse = PostLikeExperienceResponse(meta: nil, data: 300)
        let expectedExperienceResponse = GetExperiencesResponse(meta: nil, data: MockData.makeExperiences())
        
        var jsonData = try JSONEncoder().encode(expectedExperienceResponse)
        var mockSession = MockData.makeMockSession(data: jsonData)
        let mockCache = MockCacheService()
        
        var repo = await AEHomeRepo(networkService: NetworkService(session: mockSession),
                                    cachingService: mockCache,
                                    userDefaults: userDefault)
        
        _ = try await repo.getRecentExperiencesFromNetwork()
        
        
        jsonData = try JSONEncoder().encode(expectedLikeResponse)
        mockSession = MockData.makeMockSession(data: jsonData)
        repo = await AEHomeRepo(networkService: NetworkService(session: mockSession), cachingService: mockCache, userDefaults: userDefault)
        
        _ = try await repo.likeExperience(id: "123")
        
        let repoCachedItems: GetExperiencesResponse = try await repo.getRecentExperiencesFromCache()
        
        let cacheResponse = repoCachedItems.data?.filter {$0.id == "123"}.first
        
        #expect(cacheResponse?.isLiked == true, "isLiked is: \(cacheResponse?.isLiked)")
    }
}
