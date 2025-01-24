//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/20/25.
//

import SwiftUI

@main
struct RecipeAppApp: App {
    var body: some Scene {
        
        WindowGroup {
            ContentView(viewModel: ContentViewModel(apiService: APIService()))
        }
    }
}
