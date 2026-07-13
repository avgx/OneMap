import Foundation

/// Map viewer position, orientation, and scale.
public struct Viewpoint: Codable, Equatable, Sendable {
    public let center: Point3D
    public let orientation: Point3D
    public let zoom: Double

    private enum CodingKeys: String, CodingKey {
        case center
        case orientation
        case zoom
    }
}
