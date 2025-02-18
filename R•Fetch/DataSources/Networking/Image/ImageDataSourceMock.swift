//
//  ImageDataSourceMock.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import SwiftUI

actor ImageDataSourceMock: ImageNetworking {
    var fetchImageDataCallCount = 0
    var nameForImage : String {
        var result = ""
        let nameIndex = (fetchImageDataCallCount - 1) % 4
        print("value: \(nameIndex)")
        switch nameIndex {
        case 0:
            result = "Balik"
        case 1:
            result = "Blackberry"
        case 2:
            result = "Frangipan"
        case 3:
            result = "Bakewell"
        default:
            result = ""
        }

        return result
    }

    func fetchImageData(urlString: String) async throws -> Data? {
        fetchImageDataCallCount += 1
        let result = await Image(nameForImage)
            .scaleEffect(1 + (0.001 * CGFloat(fetchImageDataCallCount)))
            .data()

        return result
    }
}
