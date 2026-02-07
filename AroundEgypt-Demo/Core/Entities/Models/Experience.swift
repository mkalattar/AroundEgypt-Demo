//
//  Experience.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

nonisolated
struct Experience: Codable, Equatable {
    let id: String?
    let title: String?
    let coverPhoto: String?
    let description: String?
    var likesNo: Int?
    let viewsNo: Int?
    let recommended: Int?
    let tourHtml: String?
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverPhoto = "cover_photo"
        case description
        case likesNo = "likes_no"
        case viewsNo = "views_no"
        case recommended
        case tourHtml = "tour_html"
    }
    
    var isRecommended: Bool {
        recommended == 1
    }
}
