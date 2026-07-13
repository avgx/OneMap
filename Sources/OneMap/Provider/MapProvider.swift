import Foundation

/// Geocoding configuration stored in provider custom data.
public struct GeocodingConfig: Codable, Equatable, Sendable {
    public let name: String
    public let baseURL: String
    public let token: String
    public let secret: String

    private enum CodingKeys: String, CodingKey {
        case name
        case baseURL = "base_url"
        case token
        case secret
    }
}

/// Provider-specific custom data for geo map types.
public struct MapCustomData: Codable, Equatable, Sendable {
    public let tileURL: String?
    public let geocoding: GeocodingConfig?

    private enum CodingKeys: String, CodingKey {
        case tileURL = "tile_url"
        case geocoding = "geocodding"
    }
}

/// Map type settings within a provider.
public struct MapType: Codable, Equatable, Sendable {
    public let name: String
    public let enabled: Bool
    public let minZoom: Int?
    public let maxZoom: Int?
    public let defaultZoom: Int?
    public let defaultCenter: Point?
    public let customData: MapCustomData?

    private enum CodingKeys: String, CodingKey {
        case name
        case enabled
        case minZoom = "min_zoom"
        case maxZoom = "max_zoom"
        case defaultZoom = "default_zoom"
        case defaultCenter = "default_center"
        case customData = "custom_data"
    }
}

/// Registered map provider on the server.
public struct MapProvider: Decodable, Equatable, Sendable, Identifiable {
    public let id: String
    public let name: String
    public let apiKey: String?
    public let copyright: String?
    public let mapTypes: [String: MapType]
    public let etag: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case apiKey = "api_key"
        case copyright
        case mapTypes = "map_types"
        case etag
    }
}

/// Response for `GET /v1/maps/providers`.
public struct ListMapProvidersResponse: Decodable, Equatable, Sendable {
    public let mapProviders: [MapProvider]
    public let nextPageToken: String

    private enum CodingKeys: String, CodingKey {
        case mapProviders = "map_providers"
        case nextPageToken = "next_page_token"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mapProviders = try container.decode([MapProvider].self, forKey: .mapProviders)
        nextPageToken = try container.decodeIfPresent(String.self, forKey: .nextPageToken) ?? ""
    }
}
