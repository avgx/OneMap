import Foundation
import Testing
@testable import OneMap

enum FixtureLoader {
    static func loadData(resource: String, ext: String) throws -> Data {
        let url = try #require(Bundle.module.url(forResource: resource, withExtension: ext))
        return try Data(contentsOf: url)
    }

    static func loadListMapsResponse(
        resource: String,
        ext: String = "json",
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> ListMapsResponse {
        let data = try loadData(resource: resource, ext: ext)
        return try decoder.decode(ListMapsResponse.self, from: data)
    }

    static func firstMap(
        resource: String,
        ext: String = "json",
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> MapFull {
        let response = try loadListMapsResponse(resource: resource, ext: ext, decoder: decoder)
        return try #require(response.items.first)
    }

    static func loadMarkersResponse(
        resource: String,
        ext: String = "json",
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> GetMarkersResponse {
        let data = try loadData(resource: resource, ext: ext)
        return try decoder.decode(GetMarkersResponse.self, from: data)
    }

    static func loadMapImageResponse(
        resource: String,
        ext: String = "json",
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> GetMapImageResponse {
        let data = try loadData(resource: resource, ext: ext)
        return try decoder.decode(GetMapImageResponse.self, from: data)
    }

    static func loadProvidersResponse(
        resource: String,
        ext: String = "json",
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> ListMapProvidersResponse {
        let data = try loadData(resource: resource, ext: ext)
        return try decoder.decode(ListMapProvidersResponse.self, from: data)
    }
}
