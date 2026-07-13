import Foundation

/// Map visualization type.
public enum MapTypeKind: String, Codable, Hashable, Sendable {
    case raster = "MAP_TYPE_RASTER"
    case geo = "MAP_TYPE_GEO"
}
