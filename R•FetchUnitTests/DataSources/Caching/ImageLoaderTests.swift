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
        let loader = ImageLoader(network: mockNetwork)
        var result: Data?

        // When
        result = try await loader.loadImageData(id: uuid, path: path)

        // Then
        #expect(result != nil)
        #expect(loader.cachedIdentifiers().contains(uuid))
    }

    @Test func LoadsTwiceForSameID() async throws {
        // Given
        let mockNetwork = ImageDataSourceMock()
        let loader = ImageLoader(network: mockNetwork)
        var firstResult: Data?
        var secondResult: Data?

        // When
        firstResult = try await loader.loadImageData(id: uuid, path: path)
        secondResult = try await loader.loadImageData(id: uuid, path: path)

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
        let loader = ImageLoader(network: mockNetwork)
        let secondID = UUID()
        var firstResult: Data?
        var secondResult: Data?

        // When
        firstResult = try await loader.loadImageData(id: uuid, path: path)
        secondResult = try await loader.loadImageData(id: secondID, path: path)

        // Then
        let identifiers = loader.cachedIdentifiers()
        await #expect(mockNetwork.fetchImageDataCallCount == 2)
        #expect(firstResult != secondResult)
        #expect(identifiers.count == 2)
        #expect(identifiers.contains(uuid))
        #expect(identifiers.contains(secondID))
    }
}
