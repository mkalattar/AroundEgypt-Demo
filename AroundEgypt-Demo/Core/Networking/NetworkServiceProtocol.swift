//
//  NetworkServiceProtocol.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation

protocol URLSessionProtocol: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol NetworkServiceProtocol: Sendable {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws(AENetworkError) -> T
}
