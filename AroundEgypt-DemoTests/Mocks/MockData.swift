//
//  MockData.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation
@testable import AroundEgypt_Demo

enum MockData {
    static func makeMockSession(data: Data? = nil, statusCode: Int = 200, error: Error? = nil) -> MockURLSession {
        let session = MockURLSession()
        session.mockData = data
        session.mockStatusCode = statusCode
        session.mockError = error
        return session
    }
    
    static func makeExperiences() -> [Experience] {
        return [
            Experience(id: "123", title: "Sphinx", coverPhoto: "image.png", description: "desc", likesNo: 330, viewsNo: 590, recommended: 0, tourHtml: "tour.html"),
            Experience(id: "9090", title: "Pyramids", coverPhoto: "picture.jpg", description: "detailed desc", likesNo: 9, viewsNo: 9, recommended: 1, tourHtml: "tour2.html")
        ]
    }
}
