import Foundation

/// Raster image dimensions in pixels.
public struct ImageSize: Codable, Equatable, Sendable {
    public let width: Int
    public let height: Int

    private enum CodingKeys: String, CodingKey {
        case width
        case height
    }
}
