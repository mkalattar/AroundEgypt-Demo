//
//  AENetworkError.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import Foundation

public enum AENetworkError: Error, LocalizedError {
    case invalidURL(innerError: URLError)
    case decodingError(innerError: DecodingError)
    case invalidStatusCode(statusCode: Int)
    case requestFailed(innerError: URLError)
    case otherError(innerError: Error)

    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Check for app updates or try again later."
        case .invalidStatusCode(let statusCode):
            return "The server responded with an error (Code: \(statusCode))."
        case .requestFailed(let innerError), .invalidURL(let innerError):
            return innerError.localizedDescription
        case .otherError(let innerError):
            return innerError.localizedDescription
        }
    }
}
