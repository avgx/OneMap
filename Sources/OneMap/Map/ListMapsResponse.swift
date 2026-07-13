import Foundation

/// Response for `GET /v1/maps/list`.
public struct ListMapsResponse: Decodable, Equatable, Sendable {
    public let items: [MapFull]

    private enum CodingKeys: String, CodingKey {
        case items
    }
}

/// Response for `GET /v1/maps:batchGet`.
public struct BatchGetMapsResponse: Decodable, Equatable, Sendable {
    public let items: [MapFull]
    public let failedMapIds: [String]

    private enum CodingKeys: String, CodingKey {
        case items
        case failedMapIds = "failed_map_ids"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([MapFull].self, forKey: .items)
        failedMapIds = try container.decodeIfPresent([String].self, forKey: .failedMapIds) ?? []
    }
}

/// Response for `GET /v1/maps:getByComponent`.
public typealias GetMapsByComponentResponse = ListMapsResponse
