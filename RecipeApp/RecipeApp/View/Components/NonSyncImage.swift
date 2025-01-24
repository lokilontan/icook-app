//
//  NonSyncImage.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/22/25.
//

import SwiftUI

struct NonSyncImage: View {
    
    @StateObject private var imageDownloader = ImageDownloader()
    
    let stringUrl: String
    
    var body: some View {
        VStack {
            if let uiImage = imageDownloader.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .clipped()
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            await getImage()
        }
    }
    
    private func getImage() async {
        do {
            try await imageDownloader.fetchImage(stringUrl)
        } catch {
            print("NonSyncImage :: \(error)")
        }
    }
}

#Preview {
    NonSyncImage(stringUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
}
