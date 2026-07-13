import Foundation
import SafeEnum

/// Map configuration and display data.
public struct MapData: Codable, Equatable, Sendable {
    public let name: String
    public let type: SafeEnum<MapTypeKind>
    public let position: Point
    public let zoom: Int
    public let providerId: String
    public let mapTypeId: String
    public let imageMeta: ImageMeta?
    public let position3D: Point3D
    public let size: Point3D
    public let angle: Double
    public let parentId: String
    public let baseGeoPosition: Point
    public let viewpoint: Viewpoint?
    public let iconScale: Double?

    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case position
        case zoom
        case providerId = "provider_id"
        case mapTypeId = "map_type_id"
        case imageMeta = "image_meta"
        case position3D = "position_3d"
        case size
        case angle
        case parentId = "parent_id"
        case baseGeoPosition = "base_geo_position"
        case viewpoint
        case iconScale = "icon_scale"
    }
}
