//
//  NetworkService.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSessionProtocol
    private let decoder: JSONDecoder
    
    init(session: URLSessionProtocol = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
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
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            throw .decodingError(innerError: error)
        } catch {
            throw .otherError(innerError: error)
        }
    }
}
