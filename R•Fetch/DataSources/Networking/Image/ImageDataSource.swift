//
//  ImageDataSource.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import SwiftUI

actor ImageDataSource: ImageNetworking {
    func fetchImageData(urlString: String) async throws -> Data? {
        var result: Data?
        if let url = URL(string: urlString) {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    result = data
                } else {
                    debugPrint("### Image fetch failed with status code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 404 {
                        result = await BrokenImageIcon().data()
                    }
                }
            }
        }

        return result
    }
}
