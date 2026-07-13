import Foundation
import Testing
@testable import OneMap

@Suite("GetMapImageResponse decoding")
struct GetMapImageResponseDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode v1_maps_image_meta.json")
    func decodeImage() throws {
        let response = try FixtureLoader.loadMapImageResponse(
            resource: "v1_maps_image_meta",
            decoder: decoder
        )
        #expect(response.image.meta.sizeBytes == 126_324)
        #expect(response.image.etag == "9191900.9191900.0.0")
        #expect(response.image.data.hasPrefix("/9j/"))
    }
}
