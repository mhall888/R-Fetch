//
//  ImageDiskCache.swift
//  R•Fetch
//
//  Created by Mark Hall on 3/25/25.
//

import Foundation

protocol ImageDiskCache {
    func save(data: Data, for id: UUID) throws
    func load(for id: UUID) -> Data?
    func remove(for id: UUID)
    func clear()
}
