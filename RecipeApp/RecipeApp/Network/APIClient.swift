//
//  APIClient.swift
//  RecipeApp
//
//  Created by Vladimir Plagov on 1/20/25.
//

import Foundation

class APIClient {
    let logs: Bool
    
    init(logs: Bool = true) {
        self.logs = logs
    }
    
    func getData(url: String, retryCount: Int = 0) async throws -> Data {
        do {
            guard let httpURL = URL(string: url) else {
                throw HTTPError.badURL
            }
            
            var urlRequest = URLRequest(url: httpURL)
            
            urlRequest.httpMethod = HTTPMethod.GET.rawValue
            
            urlRequest.timeoutInterval = Constants.TIMEOUT.GET_REQUEST
            
            if logs { print("getData :: [\(urlRequest.httpMethod?.uppercased() ?? "")] '\(urlRequest.url!)'") }
            
            for (key, value) in urlRequest.allHTTPHeaderFields! {
                if logs { print("Request Header: [\(key) : \(value)]") }
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                guard let response = response as? HTTPURLResponse else {
                    throw HTTPError.invalidResponse
                }
                
                if logs { print("getData :: [\(response.statusCode)] '\(urlRequest.url!)'") }
                
                for (key, value) in response.allHeaderFields {
                    if logs { print("Response Header: [\(key) : \(value)]") }
                }
                if logs { print("Response Body: '\(String(describing: urlRequest.url)) \((!data.isEmpty) ? String(decoding: data, as: UTF8.self) : "Empty Body")'") }
                
                if !(200...299).contains(response.statusCode) {
                    throw HTTPError.code(response.statusCode)
                }
                
                return data
            } catch {
                if retryCount >= Constants.RETRY.COUNT {
                    throw HTTPError.noNetworkAvailable
                }
                if logs { print("getData :: retrying...") }
                let oneSecond = TimeInterval(Constants.RETRY.ONE_SECOND_NS)
                let delay = UInt64(oneSecond * Constants.RETRY.DELAY)
                try await Task<Never, Never>.sleep(nanoseconds: delay)
                return try await getData(url: url, retryCount: retryCount + 1)
            }
        } catch {
            throw HTTPError.mapFrom(error: error)
        }
    }
}
