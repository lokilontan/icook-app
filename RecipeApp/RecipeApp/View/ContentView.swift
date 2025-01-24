//
//  ContentView.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    private let uiImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        VStack {
            if (viewModel.isLoading) {
                ProgressView("Loading...")
            } else {
                Image("ic_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 50)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        
                        ForEach($viewModel.recipes) { recipe in
                            Link(destination: viewModel.getDetailsURL(for: recipe.wrappedValue)) {
                                RecipeItemView(recipe: recipe)
                            }
                            Divider()
                                .frame(height: 3)
                                .overlay(.white)
                                .padding(.vertical, 3)
                        }
                    }
                }
                .refreshable {
                    uiImpactFeedbackGenerator.impactOccurred()
                    viewModel.clearCache()
                    await viewModel.fetchRecipes()
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .alert(isPresented: $viewModel.isError) {
            Alert (
                title: Text("Error"),
                message: Text(viewModel.whatError),
                primaryButton: .default(
                    Text("Try Again"),
                    action: {
                        Task {
                            await viewModel.fetchRecipes()
                        }
                    }
                ),
                secondaryButton: .destructive(
                    Text("Close"),
                    action: {
                        exit(0)
                    }
                )
            )
        }
        .task {
            await viewModel.fetchRecipes()
        }
        .background(
            Image("ic_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel(apiService: APIService()))
}
