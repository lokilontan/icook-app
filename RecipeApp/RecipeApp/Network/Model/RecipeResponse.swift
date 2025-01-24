//
//  RecipeResponse.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/21/25.
//

import Foundation

// MARK: - RecipeResponse
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable {
    let cuisine, name: String
    let photoURLLarge, photoURLSmall: String?
    var sourceURL: String?
    let id: String
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case id = "uuid"
        case youtubeURL = "youtube_url"
    }
}
