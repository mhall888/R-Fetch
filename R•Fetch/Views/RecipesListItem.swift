//
//  RecipesListItem.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import SwiftUI

struct RecipesListItem: View {
    @StateObject var recipeViewModel: RecipeViewModel

    var body: some View {
        HStack {
            recipeImage
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 75)
            recipeDescription
            Spacer()
            recipeLinks
        }
        .onAppear() {
            recipeViewModel.fetchImage()
        }
    }
}

extension RecipesListItem {
    private var recipe: Recipe {
        recipeViewModel.recipe
    }
}


// MARK: - Recipe Image View Builders

extension RecipesListItem {
    @ViewBuilder
    private var recipeImage: some View {
        if let imageData = recipeViewModel.imageData {
            Image(data: imageData)?
                .resizable()
        } else if recipe.imageURL != nil {
            ProgressView()
        }
    }
}


// MARK: - Description View Builders

extension RecipesListItem {
    private var recipeDescription: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.headline)
            Text("Cuisine: \(recipe.cuisine)")
                .font(.subheadline)
        }
    }
}


// MARK: - Link Button View Builders

extension RecipesListItem {
    @ViewBuilder
    var recipeLinks: some View {
        // UIKit has defects when both buttons are visible, so customize to only show one at a time
#if canImport(UIKit)
        switch recipeViewModel.recipesViewModel.linkSelection {
        case .source:
            sourceButton
        case .youtube:
            youTubeButton
        }
#else
        sourceButton
        youTubeButton
#endif
    }

    @ViewBuilder
    var sourceButton: some View {
        linkButton(urlString: recipe.sourceURL, systemImageName: "list.bullet.clipboard")
    }

    @ViewBuilder
    var youTubeButton: some View {
        linkButton(urlString: recipe.youtubeURL, systemImageName: "video.square")
    }

    @ViewBuilder
    func linkButton(urlString: String?, systemImageName: String) -> some View {
        if let urlString,
           let url = URL(string: urlString) {
            Link(destination: url) {
                Image(systemName: systemImageName)
                    .font(.title)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    RecipesListItem(
        recipeViewModel: .preview)
}
