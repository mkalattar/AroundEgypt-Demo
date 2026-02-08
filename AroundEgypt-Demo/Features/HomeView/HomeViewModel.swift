//
//  HomeViewModel.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import Observation

protocol HomeViewModelProtocol {
    var searchText: String { get set }
    var recommendedExperiences: [Experience] { get }
    var recentExperiences: [Experience] { get }
    
    func fetchData() async
    func likeExperience(id: String) async
}

@MainActor
@Observable
final class HomeViewModel: HomeViewModelProtocol {
    private let homeDataUseCase: GetHomeDataUseCaseProtocol
    private let likeExperienceUseCase: LikeExperienceUseCaseProtocol
    private let searchExperienceUseCase: SearchExperienceUseCaseProtocol
    
    var searchText: String = ""
    var recommendedExperiences: [Experience] = []
    var recentExperiences: [Experience] = []
    
    init(homeDataUseCase: GetHomeDataUseCaseProtocol,
         likeExperienceUseCase: LikeExperienceUseCaseProtocol,
         searchExperienceUseCase: SearchExperienceUseCaseProtocol) {
        self.homeDataUseCase = homeDataUseCase
        self.likeExperienceUseCase = likeExperienceUseCase
        self.searchExperienceUseCase = searchExperienceUseCase
    }
    
    func fetchData() async {
        do {
            let response: (recent: [Experience], recommended: [Experience]) = try await self.homeDataUseCase.execute()
            
            self.recentExperiences = response.recent
            self.recommendedExperiences = response.recommended
            
        } catch {
            // Handle Error...
        }
    }
    
    func likeExperience(id: String) async {
        do {
            _ = try await self.likeExperienceUseCase.execute(id: id)
        } catch {}
    }
}


@MainActor
@Observable
final class MockHomeViewModel: HomeViewModelProtocol {
    
    var searchText: String = ""
    var recommendedExperiences: [Experience] = []
    var recentExperiences: [Experience] = []
    
    func fetchData() async {
        recommendedExperiences = [
            Experience(id: "1", title: "Nubian House", coverPhoto: "https://img.freepik.com/free-photo/lavender-field-sunset-near-valensole_268835-3910.jpg?semt=ais_hybrid&w=740&q=80", description: "Nubian House Desc", likesNo: 90, viewsNo: 90, recommended: 0, tourHtml: "", isLiked: false),
            
            Experience(id: "2", title: "Sphinx", coverPhoto: "https://cdn.britannica.com/85/99185-050-E1110E5C/Great-Sphinx-Giza-Egypt.jpg", description: "Sphinx Desc", likesNo: 90, viewsNo: 11, recommended: 1, tourHtml: "", isLiked: false),
            
            Experience(id: "3", title: "Pyramids", coverPhoto: "https://assets.newatlas.com/dims4/default/17b27a2/2147483647/strip/true/crop/3017x2011+279+0/resize/1200x800!/format/webp/quality/90/?url=https%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2F33%2F8f%2F4fcb70b045219adb1c0338de5968%2Fdepositphotos-429681190-xl.png", description: "Pyramids Desc", likesNo: 90, viewsNo: 120, recommended: 0, tourHtml: "", isLiked: false),
        ]
        
        recentExperiences = []
    }
    
    func likeExperience(id: String) async {
        
    }
}
