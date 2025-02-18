//
//  RecipesViewModelTests.swift
//  R•FetchTests
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import Testing
@testable import R_Fetch

@MainActor
struct RecipesViewModelTests {
    @Test func LoadsRecipesFromNetwork() async throws {
        // Given
        let viewModel = RecipeViewModel .preview

        // When
        viewModel.fetchImage()

        // Then
        for await value in viewModel.$imageData.values {
            if value != nil {
                break
            }
        }
    }
}
