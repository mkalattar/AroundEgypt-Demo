//
//  HomeDataUseCasesTests.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//


import Foundation
import Testing
@testable import AroundEgypt_Demo

struct HomeDataUseCasesTests {
    
    @Test("Test getting data with internet connection")
    func testGetDataWithInternetConnection() async throws {
        let mockRepo = MockHomeDataRepo()
        let nwMonitorMock = MockNetworkMonitorService()
        nwMonitorMock.enableConnection()
        
        let useCase = await GetHomeDataUseCase(repo: mockRepo, nwMonitor: nwMonitorMock)
        
        let experiencesFromNetwork: ([Experience], [Experience]) = try await useCase.execute()
        #expect(experiencesFromNetwork.0.first?.id == "123")
    }
    
    @Test("Test getting data without internet connection")
    func testGetDataWithoutInternetConnection() async throws {
        let mockRepo = MockHomeDataRepo()
        let nwMonitorMock = MockNetworkMonitorService()
        nwMonitorMock.disableConnection()
        
        let useCase = await GetHomeDataUseCase(repo: mockRepo, nwMonitor: nwMonitorMock)
        
        let experiencesFromCache: ([Experience], [Experience]) = try await useCase.execute()
        
        #expect(experiencesFromCache.0.first?.id == "9090")
    }
}
