import Foundation

/// 3D point on the map.
public struct Point3D: Codable, Equatable, Sendable {
    public let x: Double
    public let y: Double
    public let z: Double

    private enum CodingKeys: String, CodingKey {
        case x
        case y
        case z
    }
}
