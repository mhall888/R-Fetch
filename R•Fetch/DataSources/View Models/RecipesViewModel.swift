//
//  RecipesViewModel.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var linkSelection: LinkState = .source

    let imageLoader: ImageLoader?

    private let recipesNetwork: RecipesNetworking
    private var isLoading = false

    init(recipesNetwork: RecipesNetworking,
         imageNetwork: ImageNetworking) {
        self.recipesNetwork = recipesNetwork
        self.imageLoader = ImageLoader(network: imageNetwork)
    }
}

extension RecipesViewModel {
    enum LinkState: String, CaseIterable, Identifiable {
        case source
        case youtube
        var id: Self { self }
    }
}


// MARK: - Public Methods

extension RecipesViewModel {
    func fetchRecipes() {
        Task {
            do {
                let fetchedRecipes = try await fetch()
                await MainActor.run {
                    recipes = fetchedRecipes
                }
            } catch {
                // The empty state placeholder's call to action covers this error, so nothing else to do for now.
               debugPrint("fetchRecipes - error: \(error)")
            }
        }
    }
}


// MARK: - Private Methods

extension RecipesViewModel {
    private func fetch() async throws -> [Recipe] {
        var result: [Recipe] = []
        guard isLoading == false else {
            return result
        }
        isLoading = true
        defer {
            isLoading = false
        }

        result = try await recipesNetwork.fetchRecipes()

        return result
    }
}
