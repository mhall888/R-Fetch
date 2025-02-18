//
//  RecipesListView.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject var recipesViewModel: RecipesViewModel

    var body: some View {
        VStack {
            header
            if recipesViewModel.recipes.isEmpty {
                EmptyPlaceholder { refreshButton }
            } else {
                recipesList
            }
        }
        .padding(.horizontal)
        .onAppear {
            recipesViewModel.fetchRecipes()
        }
    }
}


// MARK: - Header View Builders

extension RecipesListView {
    @ViewBuilder
    private var header: some View {
        Text("Recipes")
            .font(.title)
        controls
    }

    @ViewBuilder
    private var controls: some View {
        HStack {
            Text("Count: \(recipesViewModel.recipes.count)")
#if canImport(UIKit)
            mobileControls
#elseif canImport(AppKit)
            desktopControls
#endif
        }
    }

    @ViewBuilder
    private var mobileControls: some View {
        Spacer()
        Picker(selection: $recipesViewModel.linkSelection, label: Text("Picker")) {
            Text("Source").tag(RecipesViewModel.LinkState.source)
            Text("YouTube").tag(RecipesViewModel.LinkState.youtube)
        }
    }

    @ViewBuilder
    private var desktopControls: some View {
        refreshButton
        Spacer()
    }

    @ViewBuilder
    private var refreshButton: some View {
        Button("Refresh", systemImage: "arrow.clockwise.circle", action: recipesViewModel.fetchRecipes)
            .labelStyle(.iconOnly)
    }
}


// MARK: - List View Builders

extension RecipesListView {
    @ViewBuilder
    private var recipesList: some View {
        if let loader = recipesViewModel.imageLoader {
            List(recipesViewModel.recipes) { recipe in
                let newRecipeViewModel = RecipeViewModel(recipe: recipe,
                                                         imageLoader: loader,
                                                         recipesViewModel: recipesViewModel)
                RecipesListItem(recipeViewModel: newRecipeViewModel)
            }
            .listStyle(.plain)
            .refreshable {
                recipesViewModel.fetchRecipes()
            }
        }
    }
}


// MARK: - Preview

#Preview {
    RecipesListView(recipesViewModel: .preview)
}
