import Foundation

/// Axis-aligned region on the map plane.
public struct Region: Codable, Equatable, Sendable {
    public let minCorner: Point
    public let maxCorner: Point

    private enum CodingKeys: String, CodingKey {
        case minCorner = "min_corner"
        case maxCorner = "max_corner"
    }
}

/// Viewport filter for marker requests.
public typealias EntryRegion = Region
