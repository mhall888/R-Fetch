//
//  R_FetchApp.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import SwiftUI

@main
struct R_FetchApp: App {
    let recipesViewModel = RecipesViewModel(recipesNetwork: RecipesDataSource(),
                              imageNetwork: ImageDataSource())
    var body: some Scene {
        WindowGroup {
            RecipesListView(recipesViewModel: recipesViewModel)
        }
    }
}
