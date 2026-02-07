//
//  AEHomeUseCase.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

protocol GetHomeDataUseCaseProtocol {
    func execute() async throws -> (recommended: [Experience], recent: [Experience])
}

struct GetHomeDataUseCase: GetHomeDataUseCaseProtocol {
    
    private let repo: AEHomeRepoProtocol
    private let nwMonitor: NetworkMonitorProtocol
    
    init(repo: AEHomeRepoProtocol, nwMonitor: NetworkMonitorProtocol = NetworkMonitorService.shared) {
        self.repo = repo
        self.nwMonitor = nwMonitor
    }
    
    func execute() async throws -> (recommended: [Experience], recent: [Experience]) {
        
        if nwMonitor.isConnected {
            return try await self.fetchFromNetwork()
        } else {
            return try await self.fetchFromCache()
        }
    }
    
    private func fetchFromNetwork() async throws -> ([Experience], [Experience]) {
        async let recent = repo.getRecentExperiencesFromNetwork()
        async let recommended = repo.getRecommendedExperiencesFromNetwork()
        
        let (recentResponse, recommendedResponse) = try await (recent, recommended)
        return (recentResponse.data ?? [], recommendedResponse.data ?? [])
    }
    
    private func fetchFromCache() async throws -> ([Experience], [Experience]) {
        async let recent = repo.getRecentExperiencesFromCache()
        async let recommended = repo.getRecommendedExperiencesFromCache()
        
        let (recentResponse, recommendedResponse) = try await (recent, recommended)
        return (recentResponse.data ?? [], recommendedResponse.data ?? [])
    }
}
