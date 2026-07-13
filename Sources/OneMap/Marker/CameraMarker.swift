import Foundation

/// Camera field of view on the map.
public struct FieldOfView: Codable, Equatable, Sendable {
    public let angle: Double
    public let direction: Point

    private enum CodingKeys: String, CodingKey {
        case angle
        case direction
    }
}

/// Link between immersion points on map and video.
public struct ImmersionModePointsLink: Codable, Equatable, Sendable {
    public let id: String?
    public let videoPoint: Point
    public let videoMonitorViewPoint: Point
    public let mapPoint: Point
    public let mapRelativePosition: Point3D?

    private enum CodingKeys: String, CodingKey {
        case id
        case videoPoint = "video_point"
        case videoMonitorViewPoint = "video_monitor_view_point"
        case mapPoint = "map_point"
        case mapRelativePosition = "map_relative_position"
    }
}

/// Immersion mode data for a camera marker.
public struct ImmersionData: Codable, Equatable, Sendable {
    public let position: Point?
    public let hasZoom: Bool
    public let zoom: Int
    public let links: [ImmersionModePointsLink]

    private enum CodingKeys: String, CodingKey {
        case position
        case hasZoom = "has_zoom"
        case zoom
        case links
    }
}

/// Video frame placement relative to a camera marker.
public struct VideoFrameArrangement: Codable, Equatable, Sendable {
    public let incline: Double
    public let distance: Double
    public let angle: Double

    private enum CodingKeys: String, CodingKey {
        case incline
        case distance
        case angle
    }
}

/// Camera marker details.
public struct CameraMarker: Codable, Equatable, Sendable {
    public let fieldOfView: FieldOfView
    public let immersion: ImmersionData
    public let videoFrameArrangement: VideoFrameArrangement?
    public let videoOn: Bool

    private enum CodingKeys: String, CodingKey {
        case fieldOfView = "field_of_view"
        case immersion
        case videoFrameArrangement = "video_frame_arrangement"
        case videoOn = "video_on"
    }
}
