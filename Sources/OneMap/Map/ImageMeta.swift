import Foundation

/// Raster map image metadata.
public struct ImageMeta: Codable, Equatable, Sendable {
    public let fileName: String
    public let mimeType: String
    public let name: String
    public let size: ImageSize
    public let sizeBytes: UInt64

    private enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case mimeType = "mime_type"
        case name
        case size
        case sizeBytes = "size_bytes"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fileName = try container.decode(String.self, forKey: .fileName)
        mimeType = try container.decode(String.self, forKey: .mimeType)
        name = try container.decode(String.self, forKey: .name)
        size = try container.decode(ImageSize.self, forKey: .size)
        sizeBytes = try Self.decodeFlexibleUInt64(from: container, forKey: .sizeBytes)
    }

    private static func decodeFlexibleUInt64(
        from container: KeyedDecodingContainer<CodingKeys>,
        forKey key: CodingKeys
    ) throws -> UInt64 {
        if container.contains(key) {
            if let value = try? container.decode(UInt64.self, forKey: key) {
                return value
            }
            if let int = try? container.decode(Int.self, forKey: key), int >= 0 {
                return UInt64(int)
            }
            if let string = try? container.decode(String.self, forKey: key),
               let value = UInt64(string) {
                return value
            }
        }
        throw DecodingError.dataCorruptedError(
            forKey: key,
            in: container,
            debugDescription: "Expected size_bytes as UInt64, Int, or numeric String"
        )
    }
}
