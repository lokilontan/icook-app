//
//  DataCache.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/22/25.
//

// START GENAI
import Foundation

enum DataCacheError: Error {
    case failedToWriteData(Error)
    case failedToReadData(Error)
    case failedToClearCache(Error)
}

class DataCache {
    static let shared = DataCache()
    
    private let cacheDirectory: URL
    private let fileManager: FileManager
    
    private init() {
        // Initialize FileManager and cache directory
        self.fileManager = FileManager.default
        let documentDirectories = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        self.cacheDirectory = documentDirectories.first!.appendingPathComponent("DataCache")
        
        // Create cache directory if it does not exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    func set(data: Data, forKey key: String) throws {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        do {
            try data.write(to: fileURL)
            print("DataCache :: Data cached successfully for key: \(key)")
        } catch {
            throw DataCacheError.failedToWriteData(error)
        }
    }
    
    func get(forKey key: String) throws -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        do {
            let data = try Data(contentsOf: fileURL)
            print("DataCache :: Data retrieved successfully for key: \(key)")
            return data
        } catch {
            throw DataCacheError.failedToReadData(error)
        }
    }
    
    func clearCache() throws {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
            print("DataCache :: Cache cleaned successfully.")
        } catch {
            throw DataCacheError.failedToClearCache(error)
        }
    }
}
