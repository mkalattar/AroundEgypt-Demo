//
//  LikeExperienceUseCase.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

protocol LikeExperienceUseCaseProtocol {
    func execute(id: String) async throws -> Int?
}

struct LikeExperienceUseCase: LikeExperienceUseCaseProtocol {
    
    private let repo: AEHomeRepoProtocol
    
    init(repo: AEHomeRepoProtocol) {
        self.repo = repo
    }
    
    func execute(id: String) async throws -> Int? {
        return try await repo.likeExperience(id: id)
    }
}
