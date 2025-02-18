//
//  RecipesWrapper.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

struct RecipesWrapper {
    private(set) var recipes: [Recipe]
}

extension RecipesWrapper: Decodable {
}
