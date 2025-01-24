//
//  Constants.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/20/25.
//

struct Constants {
    enum URL {
        static let VALID = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        static let MALFORMED = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        static let EMPTY = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    }
    
    enum TIMEOUT {
        static let POST_REQUEST = 7.0
        static let GET_REQUEST = 5.0
    }
    
    enum RETRY {
        static let COUNT = 3
        static let DELAY = 3.0
        static let ONE_SECOND_NS = 1_000_000_000
    }
}
