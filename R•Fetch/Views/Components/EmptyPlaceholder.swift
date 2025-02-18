//
//  EmptyPlaceholder.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import SwiftUI

struct EmptyPlaceholder<RefreshButton: View>: View {
    @ViewBuilder var refreshButton: RefreshButton

    var body: some View {
        HStack {
            warningIcon
            emptyStateMessage
#if canImport(UIKit)
            refreshButton
                .font(.title)
#endif
        }
        emptyStateImage
        Spacer()
    }
}


// MARK: - View Builders

extension EmptyPlaceholder {
    @ViewBuilder
    private var warningIcon: some View {
        Image(systemName: "exclamationmark.triangle")
            .font(.largeTitle)
            .foregroundColor(.yellow)
    }

    @ViewBuilder
    private var emptyStateImage: some View {
        Image("spicy_lamb_steak")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }

    @ViewBuilder
    private var emptyStateMessage: some View {
        var message: String {
            var result = "No recipes found. "
#if canImport(UIKit)
            result += "Tap the refresh button to try again later."
#elseif canImport(AppKit)
            result += "Click the refresh button to try again later."
#endif

            return result
        }
        Text(message)
            .fixedSize(horizontal: false, vertical: true)
            .font(.headline)
    }
}


// MARK: - Preview

#Preview {
    EmptyPlaceholder() {
        Button("Refresh", systemImage: "arrow.clockwise.circle", action: { })
            .labelStyle(.iconOnly)
    }
}
