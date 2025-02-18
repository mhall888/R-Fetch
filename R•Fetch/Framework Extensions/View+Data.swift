//
//  View+Data.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import SwiftUI

extension View {
    func data() async -> Data? {
        let result = await ImageRenderer(content: self).data()

        return result
    }
}
