//
//  HTTPError.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/20/25.
//

import Foundation

enum HTTPError: Error, Equatable {
    case badURL
    case invalidRequest
    case invalidResponse
    case invalidImage
    case code(_ code: Int)
    case timeOut
    case noNetworkAvailable
    case responseDecodingError(_ description: String)
    case urlError(_ code: URLError.Code)
    case unknownError(_ details: String)
    
    var localizedDescription: String {
        switch self {
        case .code(let code):
            return "Response status code: \(code)"
        case .responseDecodingError(let description):
            return "Response decoding error: \(description)"
        case .urlError(let description):
            return "URL error: \(description)"
        default:
            return "\(self)"
        }
    }
    
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable HTTPError
    static func mapFrom(error: Error) -> HTTPError {
        switch error {
        case is Swift.DecodingError:
            return .responseDecodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlError(urlError.code)
        case let httpError as HTTPError:
            return httpError
        default:
            return .unknownError(error.localizedDescription)
        }
    }
}
