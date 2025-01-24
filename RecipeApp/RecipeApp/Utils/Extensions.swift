//
//  Extensions.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/20/25.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: NSString { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "cannot pretty print JSON" }

        return prettyPrintedString
    }
}

extension String {
    func getUUID() -> String? {
        let pattern = "photos/([^/]+)/"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if let match = results.first {
                let idRange = match.range(at: 1)
                return nsString.substring(with: idRange)
            }
        } catch let error {
            print("Invalid regex: \(error.localizedDescription)")
        }
        
        return nil
    }
}
