//
//  Endpoint.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation

enum Endpoint {
    case recommendedExperiences
    case recentExperiences
    case likeExperience(id: String)
    case experienceDetails(id: String)
    case search(query: String)
    
    var baseURL: String {
        "https://aroundegypt.34ml.com/api/v2/experiences"
    }
    
    var path: String {
        switch self {
        case .recommendedExperiences, .recentExperiences, .search:
            return baseURL
        case let .likeExperience(id):
            return "\(baseURL)/\(id)/like"
        case .experienceDetails(id: let id):
            return "\(baseURL)/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .likeExperience:
            "POST"
        default:
            "GET"
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .recommendedExperiences:
            return [URLQueryItem(name: "filter[recommended]", value: "true")]
        case .search(let query):
            return [URLQueryItem(name: "filter[title]", value: query)]
        default:
            return nil
        }
    }
    
    func buildRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: path) else {
            throw AENetworkError.invalidURL(innerError: URLError(.badURL))
        }
        
        urlComponents.queryItems = queries
        
        guard let url = urlComponents.url else {
            throw AENetworkError.invalidURL(innerError: URLError(.badURL))
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
