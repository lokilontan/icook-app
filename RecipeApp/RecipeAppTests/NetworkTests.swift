//
//  NetworkTests.swift
//  RecipeAppTests
//
//  Created by Vladimir Plagov on 1/23/25.
//

import XCTest
@testable import RecipeApp

final class NetworkTests: XCTestCase {
    let apiClient = APIClient()
    
    func testAPIClientEmptyURLShouldThrowBadURL() async {
        let expectedError = HTTPError.badURL
        var actualError: Error?
           do {
               _ = try await apiClient.getData(url: "")
           } catch {
               actualError = error
           }
        XCTAssert(expectedError == actualError as! HTTPError)
    }

    func testAPIClientInvalidURLShouldThrow() async {
        var didFailWithError: Error?
           do {
               _ = try await apiClient.getData(url: "some BadURL.com")
           } catch {
               didFailWithError = error
           }
        XCTAssertNotNil(didFailWithError)
    }
    
    func testAPIClientValidURLReturnsNotNil() async throws {
        let data = try await apiClient.getData(url: Constants.URL.VALID)
        XCTAssertNotNil(data)
    }
    
    func testAPIClientValidURLReturnsRecipesResponse() async throws {
        let data = try await apiClient.getData(url: Constants.URL.VALID)
        _ = try JSONDecoder().decode(RecipeResponse.self, from: data)
    }
    
    func testAPIClientValidURLRecipesPopulated() async throws {
        let data = try await apiClient.getData(url: Constants.URL.VALID)
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        XCTAssertTrue(!recipeResponse.recipes.isEmpty)
    }
    
    func testAPIClientMalformedURLCannotDecode() async throws {
        let data = try await apiClient.getData(url: Constants.URL.MALFORMED)
        XCTAssertThrowsError(try JSONDecoder().decode(RecipeResponse.self, from: data))
    }
    
    func testAPIClientEmptyListShouldNotThrow() async throws {
        let data = try await apiClient.getData(url: Constants.URL.EMPTY)
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        XCTAssertTrue(recipeResponse.recipes.isEmpty)
    }

}
