import Foundation
import OneSecurity
import SafeEnum

/// Map metadata for the current user.
public struct MapMeta: Codable, Equatable, Sendable, Identifiable {
    public let id: String
    public let access: SafeEnum<MapAccess>
    public let sharing: Sharing
    public let name: String
    public let type: SafeEnum<MapTypeKind>
    public let etag: String
    public let imageEtag: String

    private enum CodingKeys: String, CodingKey {
        case id
        case access
        case sharing
        case name
        case type
        case etag
        case imageEtag = "image_etag"
    }
}
