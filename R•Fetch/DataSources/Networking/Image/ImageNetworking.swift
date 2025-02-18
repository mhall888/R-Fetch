//
//  ImageNetworking.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

protocol ImageNetworking {
    func fetchImageData(urlString: String) async throws -> Data?
}
