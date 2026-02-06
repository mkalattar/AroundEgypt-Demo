//
//  NetworkServiceTests.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Testing
import Foundation
@testable import AroundEgypt_Demo

struct NetworkServiceTests {
    
    @Test("NetworkService successfully fetches recent experiences")
    func testFetchRecentExperiences() async throws {
        let expectedResponse = GetExperiencesResponse(meta: nil, data: MockData.makeExperiences())
        let jsonData = try JSONEncoder().encode(expectedResponse)
        let mockSession = MockData.makeMockSession(data: jsonData)
        let networkService = await NetworkService(session: mockSession)
        
        let response: GetExperiencesResponse = try await networkService.fetch(from: .recentExperiences)
        
        #expect(response.data?.count == expectedResponse.data?.count)
        await #expect(response.data?.first?.title == "Sphinx")
    }
    
    @Test("NetworkService successfully posts a like to an experience")
    func testPostLikeToExperience() async throws {
        let expectedResponse = PostLikeExperienceResponse(meta: nil, data: 300)
        let jsonData = try JSONEncoder().encode(expectedResponse)
        let mockSession = MockData.makeMockSession(data: jsonData)
        let networkService = await NetworkService(session: mockSession)
        
        let response: PostLikeExperienceResponse = try await networkService.fetch(from: .likeExperience(id: "2"))
        
        #expect(response.data == expectedResponse.data)
    }
    
    @Test("NetworkService throws error on 404 & 500", arguments: [404, 500])
    func testFetchFailure(errorCode: Int) async throws {
        let mockSession = MockData.makeMockSession(data: Data(), statusCode: errorCode)
        let networkService = await NetworkService(session: mockSession)
        
        await #expect(throws: AENetworkError.self) {
            let _: GetExperiencesResponse = try await networkService.fetch(from: .recentExperiences)
        }
    }
}
