import Foundation
import Testing
@testable import OneMap

@Suite("ListMapProvidersResponse decoding")
struct ListMapProvidersResponseDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode v1_maps_providers.json")
    func decodeProviders() throws {
        let response = try FixtureLoader.loadProvidersResponse(
            resource: "v1_maps_providers",
            decoder: decoder
        )
        #expect(response.mapProviders.count == 1)
        #expect(response.nextPageToken.isEmpty)

        let provider = try #require(response.mapProviders.first)
        #expect(provider.id == "D7287DA0-A7FF-405F-8166-B6BAF26D066C")
        #expect(provider.apiKey == "example-api-key")
        #expect(provider.mapTypes["D7287DA0-A7FF-405F-8166-B6BAF26D066C"]?.enabled == true)
        #expect(
            provider.mapTypes["D7287DA0-A7FF-405F-8166-B6BAF26D066C"]?.customData?.tileURL
                == "https://example.com/tiles/{z}/{x}/{y}"
        )
    }
}
