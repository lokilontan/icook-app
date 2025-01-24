//
//  ImageDownloader.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/22/25.
//

import Foundation
import SwiftUI

@MainActor
class ImageDownloader: ObservableObject {
    
    let apiClient: APIClient = APIClient(logs: false)

    @Published var uiImage: UIImage?
    private let cache = DataCache.shared
    
    func fetchImage(_ string: String) async throws {
        do {
            if let cachedData = try cache.get(forKey: string.getUUID()!) {
                guard let uiImage = UIImage(data: cachedData) else {
                    throw HTTPError.invalidImage
                }
                self.uiImage = uiImage
            }
        } catch {
            let data = try await apiClient.getData(url: string)
            
            try cache.set(data: data, forKey: string.getUUID()!)
            
            guard let uiImage = UIImage(data: data) else {
                throw HTTPError.invalidImage
            }
            self.uiImage = uiImage
        }
    }
}
