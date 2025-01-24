//
//  ContentViewModel.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/21/25.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = true
    @Published var isError: Bool = false
    @Published var whatError: String = ""
    
    func fetchRecipes() async {
        isLoading = true
        do {
            recipes = try await apiService.fetchRecipes()
            if (recipes.isEmpty) { throw AppError.noRecipesAvailable }
            print("fetchRecipes() :: Success!")
        } catch {
            self.whatError = "\(error)"
            print("fetchRecipes() :: Failure! :: \(whatError)")
            isError = true
        }
        isLoading = false
    }
    
    func getDetailsURL(for recipe: Recipe) -> URL {
        guard let sourceURLString = recipe.sourceURL else {
            guard let youtubeURLString = recipe.youtubeURL else {
                return URL(string: "https://www.google.com/")!
            }
            return URL(string: youtubeURLString)!
        }
        return URL(string: sourceURLString)!
    }
    
    func clearCache() {
        do {
            try DataCache.shared.clearCache()
        } catch {
            whatError = error.localizedDescription
            isError = true
        }
        
    }
    
    deinit {
        try? DataCache.shared.clearCache()
    }
}
