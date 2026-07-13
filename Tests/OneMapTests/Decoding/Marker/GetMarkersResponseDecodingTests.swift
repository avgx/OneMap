import Foundation
import Testing
@testable import OneMap

@Suite("GetMarkersResponse decoding")
struct GetMarkersResponseDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode v1_maps_markers_camera.json")
    func decodeCameraMarkers() throws {
        let response = try FixtureLoader.loadMarkersResponse(
            resource: "v1_maps_markers_camera",
            decoder: decoder
        )
        #expect(response.markers.count == 2)
        #expect(response.collapsedMarkers.isEmpty)

        let marker = try #require(
            response.markers["hosts/Node-Example/DeviceIpint.2/SourceEndpoint.video:0:0"]
        )
        #expect(marker.cameraMarker != nil)
        #expect(marker.componentMarker == nil)
        #expect(marker.cameraMarker?.videoOn == false)
        #expect(marker.cameraMarker?.fieldOfView.angle == 60.000001669652114)
    }

    @Test("encode and decode markers for cache round-trip")
    func roundTripMarkers() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let response = try FixtureLoader.loadMarkersResponse(
            resource: "v1_maps_markers_camera",
            decoder: decoder
        )

        let data = try encoder.encode(response.markers)
        let decoded = try decoder.decode([String: Marker].self, from: data)
        #expect(decoded == response.markers)
    }
}

@Suite("GetMarkersRequest encoding")
struct GetMarkersRequestEncodingTests {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    @Test("encode and decode request body")
    func roundTrip() throws {
        let request = GetMarkersRequest(
            mapId: "11111111-1111-1111-1111-111111111111",
            entryRegion: Region(
                minCorner: Point(x: -1.0, y: -1.0),
                maxCorner: Point(x: 1.0, y: 1.0)
            ),
            collapseDistance: 0.08
        )

        let data = try encoder.encode(request)
        let decoded = try decoder.decode(GetMarkersRequest.self, from: data)
        #expect(decoded.mapId == request.mapId)
        #expect(decoded.collapseDistance == request.collapseDistance)
    }
}
