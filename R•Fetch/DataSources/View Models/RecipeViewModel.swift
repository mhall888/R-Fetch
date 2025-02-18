//
//  RecipeViewModel.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    private(set) var recipe: Recipe
    private(set) var imageLoader: ImageLoader
    private(set) var recipesViewModel: RecipesViewModel

    @Published var imageData: Data?
    private var isLoading = false

    init(
        recipe: Recipe,
        imageLoader: ImageLoader,
        recipesViewModel: RecipesViewModel
    ) {
        self.recipe = recipe
        self.imageLoader = imageLoader
        self.recipesViewModel = recipesViewModel
    }
}


// MARK: - Public Methods

extension RecipeViewModel {
    func fetchImage() {
        Task {
            do {
                let fetchedData = try await fetch()
                await MainActor.run {
                    imageData = fetchedData
                }
            } catch {
                // handle the error in some way
                debugPrint("fetchImage - error: \(error)")
            }
        }
    }
}


// MARK: - Private Methods

extension RecipeViewModel {
    private func fetch() async throws -> Data? {
        var result: Data?
        guard isLoading == false else {
            return result
        }
        isLoading = true
        defer {
            isLoading = false
        }

        if let uuid = UUID(uuidString: recipe.id),
           let path = recipe.imageURL {
            result = try await imageLoader.loadImageData(id: uuid, path: path)
        }

        return result
    }
}
