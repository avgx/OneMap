import Foundation
import RequestResponse

/// Domain API (Native BL `v1/maps*`).
public enum MapApi {
    /// Endpoint: `GET /v1/maps/list`
    public static func list(view: MapViewMode? = nil) -> Request<ListMapsResponse> {
        var queryItems: [(String, String?)] = []

        if let view {
            queryItems.append(("view", view.rawValue))
        }

        return Request(
            path: "v1/maps/list",
            method: .get,
            query: queryItems.isEmpty ? nil : queryItems
        )
    }

    /// Endpoint: `GET /v1/maps:batchGet`
    public static func batchGet(mapIds: [String]) -> Request<BatchGetMapsResponse> {
        let queryItems = mapIds.map { ("map_ids", Optional($0)) }
        return Request(
            path: "v1/maps:batchGet",
            method: .get,
            query: queryItems.isEmpty ? nil : queryItems
        )
    }

    /// Endpoint: `GET /v1/maps:getByComponent`
    public static func getByComponent(
        componentName: String,
        view: MapViewMode? = nil
    ) -> Request<GetMapsByComponentResponse> {
        var queryItems: [(String, String?)] = [
            ("component_name", componentName),
        ]

        if let view {
            queryItems.append(("view", view.rawValue))
        }

        return Request(
            path: "v1/maps:getByComponent",
            method: .get,
            query: queryItems
        )
    }

    /// Endpoint: `GET /v1/maps/image`
    public static func image(mapId: String) -> Request<GetMapImageResponse> {
        Request(
            path: "v1/maps/image",
            method: .get,
            query: [("map_id", mapId)]
        )
    }

    /// Endpoint: `POST /v1/maps/markers`
    public static func markers(_ body: GetMarkersRequest) -> Request<GetMarkersResponse> {
        Request(
            path: "v1/maps/markers",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `GET /v1/maps/providers`
    public static func providers(
        pageSize: Int? = nil,
        pageToken: String? = nil
    ) -> Request<ListMapProvidersResponse> {
        var queryItems: [(String, String?)] = []

        if let pageSize {
            queryItems.append(("page_size", String(pageSize)))
        }
        if let pageToken {
            queryItems.append(("page_token", pageToken))
        }

        return Request(
            path: "v1/maps/providers",
            method: .get,
            query: queryItems.isEmpty ? nil : queryItems
        )
    }
}
