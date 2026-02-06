//
//  Endpoint.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//
import Testing
import Foundation
@testable import AroundEgypt_Demo

struct EndpointTests {
    
    @Test("Endpoints build correctly", arguments: [
        (Endpoint.recentExperiences, "/experiences", "GET"),
        (Endpoint.experienceDetails(id: "123"), "/experiences/123", "GET"),
        (Endpoint.recommendedExperiences, "?filter[recommended]=true", "GET"),
        (Endpoint.search(query: "Cairo"), "?filter[title]=Cairo", "GET"),
        (Endpoint.likeExperience(id: "123"), "/experiences/123/like", "POST")
    ])
    func testEndpointsBuild(endpoint: Endpoint, expectedURL: String, expectedMethod: String) throws {
        let request = try endpoint.buildRequest()
        let decodedURL = request.url?.absoluteString.removingPercentEncoding ?? ""
        
        #expect(decodedURL.contains(expectedURL) == true,
                "Failed with value: \(decodedURL)")
        #expect(request.httpMethod == expectedMethod)
    }
}
