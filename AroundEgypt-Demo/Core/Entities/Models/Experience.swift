//
//  Experience.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

struct Experience: Codable {
    let id: String?
    let title: String?
    let coverPhoto: String?
    let description: String?
    let likesNo: Int?
    let viewsNo: Int?
    let recommended: Int?
    let tourHtml: String?
    
    var isRecommended: Bool {
        recommended == 1
    }
}
