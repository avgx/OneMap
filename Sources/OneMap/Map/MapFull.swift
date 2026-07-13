import Foundation

/// Full map entry with metadata and data.
public struct MapFull: Codable, Equatable, Sendable, Identifiable {
    public var id: String { meta.id }

    public let meta: MapMeta
    public let data: MapData

    private enum CodingKeys: String, CodingKey {
        case meta
        case data
    }
}
