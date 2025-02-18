//
//  ImageRenderer+Data.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import SwiftUI

/*
// This is only here to focus on Swift 6 compatibility. It can be turned on to eliminate the initial errors when
// migrating from Swift 5 to 6. Then other downstream issues can be addressed. I would not recommend using it
// in production code.
extension ImageRenderer: @retroactive @unchecked Sendable {
}
*/

extension ImageRenderer {
    func data() async -> Data? {
        var result: Data?
#if canImport(UIKit)
        if let image = await uiImage {
            result = image.pngData()
        }
#elseif canImport(AppKit)
        if let image = await nsImage {
            result = image.tiffRepresentation
        }
#endif

        return result
    }
}
