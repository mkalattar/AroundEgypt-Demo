//
//  AECity.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

struct AECity: Codable {
    let id: Int?
    let name: String?
    let disable: Bool?
    let topPick: Int?
    
    var isTopPick: Bool {
        topPick == 1
    }
}
