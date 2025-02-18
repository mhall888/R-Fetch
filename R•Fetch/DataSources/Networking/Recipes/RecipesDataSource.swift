//
//  RecipesDataSource.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

actor RecipesDataSource: RecipesNetworking {
    func fetchRecipes() async throws -> [Recipe] {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
//        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
//        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        let result = try await RecipesDataSource.decodedData(from: urlString)

        return result
    }
}

extension RecipesDataSource {
    static func decodedData(from urlString: String) async throws -> [Recipe] {
        var result = [Recipe]()
        if let url = URL(string: urlString) {
            let (data, _) = try await URLSession.shared.data(from: url)
            let wrapper = try JSONDecoder().decode(RecipesWrapper.self, from: data)
            result = wrapper.recipes
        }

        return result
    }
}
