//
//  MockCacheService.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import Foundation
@testable import AroundEgypt_Demo

actor MockCacheService: CacheServiceProtocol {
    
    private var storage: [String: Data] = [:]
    
    func save<T>(_ data: T, forKey key: String) async throws where T : Encodable {
        let encoded = try JSONEncoder().encode(data)
        storage[key] = encoded
    }
    
    func load<T>(forKey key: String) async throws -> T? where T : Decodable {
        let data = storage[key]
        if let data {
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            return nil
        }
    }
    
    func clearCache(forKey key: String) async throws {
        storage.removeAll()
    }
}
