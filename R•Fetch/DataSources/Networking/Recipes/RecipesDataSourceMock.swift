//
//  RecipesDataSourceMock.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import SwiftUI

actor RecipesDataSourceMock: RecipesNetworking {
    var fetchRecipesCallCount = 0

    func fetchRecipes() async throws -> [Recipe] {
        fetchRecipesCallCount += 1
        let url = Bundle.main.url(forResource: "recipes_Four", withExtension: "json")
        let result = try await RecipesDataSource.decodedData(from: url?.absoluteString ?? "")

        return result
    }
}
