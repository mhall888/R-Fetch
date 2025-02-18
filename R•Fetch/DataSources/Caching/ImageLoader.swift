//
//  ImageLoader.swift
//  R•Fetch
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation

@MainActor
class ImageLoader {
    private var imageData = [UUID: Data]()
    private let network: ImageNetworking

    init(network: ImageNetworking) {
        self.network = network
    }
}


// MARK: - Public Methods

extension ImageLoader {
    func loadImageData(id: UUID, path: String) async throws -> Data? {
        var result: Data?
        if let data = imageData[id] {
            result = data
        } else {
            do {
                if let data = try await network.fetchImageData(urlString: path) {
                    result = cacheImageData(for: id, data)
                } else {
                    debugPrint("### loadImageData - nil result for \(path)")
                }
            } catch {
                debugPrint("### Error thrown fetching image data for\npath -> \(path):\n\(error)")
                // Leave the cache unchanged, so a retry will occur... might just be offline.
                // TODO: Create a status enum to indicate loading, cached, broken link (404) and retry to differentiate.
            }
        }

        return result
    }

    func cachedIdentifiers() -> [UUID] {
        Array(imageData.keys)
    }
}


// MARK: - Private

extension ImageLoader {
    private func cacheImageData(for id: UUID, _ data: Data) -> Data {
        imageData[id] = data
//        debugPrint("self: \(Unmanaged.passUnretained((self)).toOpaque()), count: \(imageData.count), stashed id: \(id) - data: \(String(describing: data))")

        return data
    }
}
