//
//  RecipesViewModel+Preview.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

extension RecipesViewModel {
    static let preview = RecipesViewModel(recipesNetwork: RecipesDataSourceMock(),
                                         imageNetwork: ImageDataSourceMock())
}
