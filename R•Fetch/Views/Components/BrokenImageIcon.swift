//
//  BrokenImageIcon.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import SwiftUI

struct BrokenImageIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "photo")
            Image(systemName: "circle.slash")
                .foregroundColor(Color.red)
                .font(.largeTitle)
        }
    }
}

#Preview {
    BrokenImageIcon()
}
