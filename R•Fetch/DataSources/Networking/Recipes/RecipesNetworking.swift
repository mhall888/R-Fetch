//
//  RecipesNetworking.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

protocol RecipesNetworking {
    func fetchRecipes() async throws -> [Recipe]
}
