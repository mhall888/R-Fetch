//
//  DefaultImageDiskCache.swift
//  R•Fetch
//
//  Created by Mark Hall on 3/25/25.
//

import Foundation

final class DefaultImageDiskCache: ImageDiskCache {
    static let defaultCacheFolderName: String = "ImageCache"
    private let cacheFileExtension: String = "imgcache"
    private let directory: URL

    init(subdirectory: String = defaultCacheFolderName) {
        let base = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        self.directory = base.appendingPathComponent(subdirectory)

        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    }

    private func fileURL(for id: UUID) -> URL {
        directory.appendingPathComponent("\(id.uuidString).\(cacheFileExtension)")
    }

    func save(data: Data, for id: UUID) throws {
        let url = fileURL(for: id)
        try data.write(to: url, options: .atomic)
    }

    func load(for id: UUID) -> Data? {
        let url = fileURL(for: id)
        return try? Data(contentsOf: url)
    }

    func remove(for id: UUID) {
        let url = fileURL(for: id)
        try? FileManager.default.removeItem(at: url)
    }

    func clear() {
        let contents = (try? FileManager.default.contentsOfDirectory(at: directory,
                                                                     includingPropertiesForKeys: nil)) ?? []
        contents.forEach {
            try? FileManager.default.removeItem(at: $0)
        }
    }
}
