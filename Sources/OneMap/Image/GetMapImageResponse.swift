import Foundation

/// Map raster image payload.
public struct MapImage: Decodable, Equatable, Sendable {
    public let meta: ImageMeta
    public let data: String
    public let etag: String

    private enum CodingKeys: String, CodingKey {
        case meta
        case data
        case etag
    }
}

/// Response for `GET /v1/maps/image`.
public struct GetMapImageResponse: Decodable, Equatable, Sendable {
    public let image: MapImage

    private enum CodingKeys: String, CodingKey {
        case image
    }
}
