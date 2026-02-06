//
//  Meta.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

struct Meta: Codable {
    let code: Int?
    let errors: [APIError]?
    let exception: String?
}

struct APIError: Codable {
    let type: String?
    let message: String?
}
