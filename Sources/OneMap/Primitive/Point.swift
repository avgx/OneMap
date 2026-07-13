import Foundation

/// 2D point on the map plane.
public struct Point: Codable, Equatable, Sendable {
    public let x: Double
    public let y: Double

    private enum CodingKeys: String, CodingKey {
        case x
        case y
    }
}
