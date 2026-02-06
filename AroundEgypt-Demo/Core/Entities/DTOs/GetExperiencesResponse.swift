//
//  GetRecentExperiencesResponse.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

nonisolated
struct GetExperiencesResponse: Codable {
    let meta: Meta?
    let data: [Experience]?
}
