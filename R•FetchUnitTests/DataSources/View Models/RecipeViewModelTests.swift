//
//  RecipeViewModelTests.swift
//  R•FetchTests
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import Testing
@testable import R_Fetch

@MainActor
struct RecipeViewModelTests {
    @Test func LoadsRecipesFromNetwork() async throws {
        // Given
        let expectedCount = 4
        let viewModel = RecipesViewModel.preview

        // When
        viewModel.fetchRecipes()

        // Then
        for await value in viewModel.$recipes.values {
            if value.count == expectedCount {
                break
            }
        }
    }
}
