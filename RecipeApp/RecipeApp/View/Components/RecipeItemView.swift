//
//  RecipeItemView.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/21/25.
//

import SwiftUI

struct RecipeItemView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .padding(5)
                .background(.ultraThinMaterial.opacity(0.7))
                .cornerRadius(10)
                .fontWeight(.thin)
                .font(.largeTitle)
            
            Spacer()

            Text(recipe.cuisine)
                .padding(5)
                .background(.mint.opacity(0.8))
                .cornerRadius(10)
                .fontWeight(.semibold)
                .font(.footnote)

        }
        .foregroundStyle(.white)
        .padding(7)
        .frame(maxWidth: .infinity, idealHeight: 150, alignment: .leading)
        .background(
            NonSyncImage(stringUrl: recipe.photoURLLarge ?? "")
        )
    }
}

#Preview {
    RecipeItemView(recipe: .constant(Recipe(
        cuisine: "Malaysian",
        name: "Apam Balik",
        photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    )))
}
