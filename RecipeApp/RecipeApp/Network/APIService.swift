//
//  APIService.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/20/25.
//

import Foundation

class APIService {
    let apiClient: APIClient = APIClient()
    
    func fetchRecipes() async throws -> [Recipe] {
        let data = try await apiClient.getData(url: Constants.URL.VALID)
        let decoder = JSONDecoder()
        var recipes: [Recipe] = []
        do {
            recipes = try decoder.decode(RecipeResponse.self, from: data).recipes
        } catch {
            throw HTTPError.responseDecodingError(error.localizedDescription)
        }
        return recipes
    }
}
