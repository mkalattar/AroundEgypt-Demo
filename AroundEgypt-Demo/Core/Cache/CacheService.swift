//
//  VehiclePersisterType.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation

protocol CacheServiceProtocol: Actor, Sendable {
    func save<T: Encodable>(_ data: T, forKey key: String) async throws
    func load<T: Decodable>(forKey key: String) async throws -> T?
    func clearCache(forKey key: String) async throws
}

actor CacheService: CacheServiceProtocol {
    private let directoryURL: URL
    private let fileManager: FileManager
    
    init(directoryURL: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0],
         fileManager: FileManager = .default) {
        self.directoryURL = directoryURL
        self.fileManager = fileManager
    }

    func save<T: Encodable>(_ data: T, forKey key: String) async throws {
        let url = directoryURL.appendingPathComponent(key)
        let encoded = try JSONEncoder().encode(data)
        try await Task.detached {
            try encoded.write(to: url, options: .atomic)
        }.value
    }

    func load<T: Decodable>(forKey key: String) async throws -> T? {
        let url = directoryURL.appendingPathComponent(key)
        
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        
        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode(T.self, from: data)
    }

    func clearCache(forKey key: String) async throws {
        let url = directoryURL.appendingPathComponent(key)
        
        if fileManager.fileExists(atPath: url.path) {
            try fileManager.removeItem(at: url)
        }
    }
}
