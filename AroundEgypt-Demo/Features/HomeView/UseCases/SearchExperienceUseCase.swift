//
//  SearchExperienceUseCase.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

protocol SearchExperienceUseCaseProtocol {
    func execute(query: String) async throws -> [Experience]?
}

struct SearchExperienceUseCase: SearchExperienceUseCaseProtocol {
    
    private let repo: AEHomeRepoProtocol
    
    init(repo: AEHomeRepoProtocol) {
        self.repo = repo
    }
    
    func execute(query: String) async throws -> [Experience]? {
        return try await repo.searchExperiences(query: query).data
    }
}
