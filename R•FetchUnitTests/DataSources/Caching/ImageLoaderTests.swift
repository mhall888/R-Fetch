//
//  ImageLoaderTests.swift
//  R•FetchTests
//
//  Created by Mark Hall on 2/17/25.
//

import Foundation
import Testing
@testable import R_Fetch

@MainActor
struct ImageLoaderTests {
    let path = "https://fake.url/lambSteak"
    let uuid = UUID()

    @Test func LoadsImageFromNetwork() async throws {
        // Given
        let mockNetwork = ImageDataSourceMock()
        let mockDiskCache = ImageDiskCacheMock()
        let loader = ImageLoader(network: mockNetwork,
                                 diskCache: mockDiskCache)
        var result: Data?

        // When
        result = try await loader.loadImageData(from: path, for: uuid)

        // Then
        #expect(result != nil)
        #expect(loader.cachedIdentifiers().contains(uuid))
        #expect(mockDiskCache.savedIDs.contains(uuid))
        await #expect(mockNetwork.fetchImageDataCallCount == 1)
    }

    @Test func LoadsImageFromDiskCache() async throws {
        // Given
        let mockNetwork = ImageDataSourceMock()
        let mockDiskCache = ImageDiskCacheMock()
        let loader = ImageLoader(network: mockNetwork,
                                 diskCache: mockDiskCache)
        try? mockDiskCache.save(data: Data(), for: uuid)
        var result: Data?

        // When
        result = try await loader.loadImageData(from: path, for: uuid)

        // Then
        #expect(result != nil)
        #expect(loader.cachedIdentifiers().contains(uuid))
        await #expect(mockNetwork.fetchImageDataCallCount == 0)
    }

    @Test func LoadsTwiceForSameID() async throws {
        // Given
        let mockNetwork = ImageDataSourceMock()
        let mockDiskCache = ImageDiskCacheMock()
        let loader = ImageLoader(network: mockNetwork,
                                 diskCache: mockDiskCache)
        var firstResult: Data?
        var secondResult: Data?

        // When
        firstResult = try await loader.loadImageData(from: path, for: uuid)
        secondResult = try await loader.loadImageData(from: path, for: uuid)

        // Then
        let identifiers = loader.cachedIdentifiers()
        await #expect(mockNetwork.fetchImageDataCallCount == 1)
        #expect(firstResult == secondResult)
        #expect(identifiers.count == 1)
        #expect(identifiers.contains(uuid))
    }

    @Test func LoadsTwiceForDifferentIDs() async throws {
        // Given
        let mockNetwork = ImageDataSourceMock()
        let mockDiskCache = ImageDiskCacheMock()
        let loader = ImageLoader(network: mockNetwork,
                                 diskCache: mockDiskCache)
        let secondID = UUID()
        var firstResult: Data?
        var secondResult: Data?

        // When
        firstResult = try await loader.loadImageData(from: path, for: uuid)
        secondResult = try await loader.loadImageData(from: path, for: secondID)

        // Then
        let identifiers = loader.cachedIdentifiers()
        await #expect(mockNetwork.fetchImageDataCallCount == 2)
        #expect(firstResult != secondResult)
        #expect(identifiers.count == 2)
        #expect(identifiers.contains(uuid))
        #expect(identifiers.contains(secondID))
    }
}
