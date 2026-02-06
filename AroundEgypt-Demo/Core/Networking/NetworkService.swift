//
//  NetworkService.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws(AENetworkError) -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws(AENetworkError) -> T {
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: endpoint.buildRequest())
        } catch let error as URLError {
            throw .requestFailed(innerError: error)
        } catch {
            throw .otherError(innerError: error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw .invalidStatusCode(statusCode: -1)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw .invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        // 4. Decode
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw .decodingError(innerError: error)
        } catch {
            throw .otherError(innerError: error)
        }
    }
}
