import Foundation
import Testing
@testable import OneMap

@Suite("ListMapsResponse decoding")
struct ListMapsResponseDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode v1_maps_list_raster.json")
    func decodeRasterList() throws {
        let response = try FixtureLoader.loadListMapsResponse(
            resource: "v1_maps_list_raster",
            decoder: decoder
        )
        #expect(response.items.count == 1)

        let map = try #require(response.items.first)
        #expect(map.id == "11111111-1111-1111-1111-111111111111")
        #expect(map.meta.access.value == .full)
        #expect(map.meta.type.value == .raster)
        #expect(map.data.imageMeta?.sizeBytes == 126_324)
        #expect(map.data.imageMeta?.size.width == 1024)
    }
}

@Suite("BatchGetMapsResponse decoding")
struct BatchGetMapsResponseDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode batch response with defaults")
    func decodeBatchDefaults() throws {
        let json = """
        {
          "items": [],
          "failed_map_ids": ["missing-map-id"]
        }
        """
        let response = try decoder.decode(BatchGetMapsResponse.self, from: Data(json.utf8))
        #expect(response.items.isEmpty)
        #expect(response.failedMapIds == ["missing-map-id"])
    }
}
