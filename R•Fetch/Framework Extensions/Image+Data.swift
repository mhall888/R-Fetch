//
//  Image+Data.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import SwiftUI

extension Image {
    init?(data: Data) {
#if canImport(UIKit)
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
#elseif canImport(AppKit)
        if let nsImage = NSImage(data: data) {
            self.init(nsImage: nsImage)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

    func data() async -> Data? {
        let result = await ImageRenderer(content: self).data()

        return result
    }
}
