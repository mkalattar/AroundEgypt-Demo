//
//  CacheManagerTests.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Testing
import Foundation
@testable import AroundEgypt_Demo

struct CacheManagerTests {
    
    @Test("Test persisting & overwriting data")
    func testPersistingData() async throws {
        let tempDirectory = try MockData.makeTempFileDirectory()
        
        defer {
            try? FileManager.default.removeItem(at: tempDirectory)
        }
        
        let cacheManager = CacheService(directoryURL: tempDirectory)
        
        let data = MockData.makeExperiences()
        let dataToCache = GetExperiencesResponse(meta: nil, data: data)
        let key = "test_key"
        
        try await cacheManager.save(dataToCache, forKey: key)
        var loaded: GetExperiencesResponse? = try await cacheManager.load(forKey: key)
        
        #expect(loaded != nil)
        #expect(loaded?.data?.count == data.count)
        #expect(loaded?.data?.first?.title == "Sphinx")
        #expect(loaded?.data?.first?.id == dataToCache.data?.first?.id)
        
        let replacingCacheData = GetExperiencesResponse(meta: nil, data: data.reversed())
        try await cacheManager.save(replacingCacheData, forKey: key)
        loaded = try await cacheManager.load(forKey: key)
        
        #expect(loaded?.data?.first?.title == "Pyramids")
    }
    
    @Test("Cached data persists across cache manager instances")
    func testPersistence() async throws {
        let tempDirectory = try MockData.makeTempFileDirectory()
        
        defer {
            try? FileManager.default.removeItem(at: tempDirectory)
        }
        
        let data = MockData.makeExperiences()
        let dataToCache = GetExperiencesResponse(meta: nil, data: data)
        let key = "test_cache"
        
        let cacheManager1 = CacheService(directoryURL: tempDirectory)
        try await cacheManager1.save(dataToCache, forKey: key)
        
        let cacheManager2 = CacheService(directoryURL: tempDirectory)
        let loaded: GetExperiencesResponse? = try await cacheManager2.load(forKey: key)
        
        #expect(loaded != nil)
        #expect(loaded?.data?.first?.title == "Sphinx")
    }
}
