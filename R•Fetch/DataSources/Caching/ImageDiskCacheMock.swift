//
//  ImageDiskCacheMock.swift
//  R•Fetch
//
//  Created by Mark Hall on 3/26/25.
//

import Foundation

final class ImageDiskCacheMock: ImageDiskCache {
    private var storage: [UUID: Data] = [:]

    // Track actions for testing expectations
    private(set) var savedIDs: [UUID] = []
    private(set) var removedIDs: [UUID] = []
    private(set) var cleared: Bool = false
}

extension ImageDiskCacheMock {
    func save(data: Data, for id: UUID) throws {
        storage[id] = data
        savedIDs.append(id)
    }

    func load(for id: UUID) -> Data? {
        return storage[id]
    }

    func remove(for id: UUID) {
        storage.removeValue(forKey: id)
        removedIDs.append(id)
    }

    func clear() {
        storage.removeAll()
        cleared = true
    }

    // Convenience for test assertions
    func contains(_ id: UUID) -> Bool {
        storage.keys.contains(id)
    }
}
