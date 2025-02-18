//
//  Recipe.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

struct Recipe: Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let imageURL: String?
    let sourceURL: String?
    let youtubeURL: String?
}

extension Recipe: Hashable {
}

extension Recipe: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case imageURL = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
