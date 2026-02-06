//
//  MockURLSession.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation
@testable import AroundEgypt_Demo

final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
    var mockData: Data?
    var mockStatusCode: Int = 200
    var mockError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData else {
            throw URLError(.badServerResponse)
        }
        
        let response = HTTPURLResponse( url: request.url!,
                                        statusCode: mockStatusCode,
                                        httpVersion: nil,
                                        headerFields: nil)!
        
        return (data, response)
    }
}
