//
//  RecipeViewModel+Preview.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

extension RecipeViewModel {
    static let preview = RecipeViewModel(recipe: .preview,
                                         imageLoader: ImageLoader(network: ImageDataSourceMock()),
                                         recipesViewModel: .preview)
}
