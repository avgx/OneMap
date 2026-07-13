import Foundation

/// Marker displayed on the map.
public struct Marker: Codable, Equatable, Sendable {
    public let position: Point
    public let componentName: String
    public let displayTitle: Bool
    public let componentDomain: String
    public let position3D: Point3D
    public let iconScale: Double?
    public let cameraMarker: CameraMarker?
    public let componentMarker: ComponentMarkerDetails?
    public let transitionMarker: TransitionMarker?
    public let immersionModeMarker: ImmersionModeMarker?
    public let macroMarker: MacroMarker?
    public let counterMarker: CounterMarker?

    private enum CodingKeys: String, CodingKey {
        case position
        case componentName = "component_name"
        case displayTitle = "display_title"
        case componentDomain = "component_domain"
        case position3D = "position_3d"
        case iconScale = "icon_scale"
        case cameraMarker = "camera_marker"
        case componentMarker = "component_marker"
        case transitionMarker = "transition_marker"
        case immersionModeMarker = "immersion_mode_marker"
        case macroMarker = "macro_marker"
        case counterMarker = "counter_marker"
    }
}

/// Collapsed marker group.
public struct MarkerGroup: Codable, Equatable, Sendable {
    public let position: Point
    public let boundaryRegion: Region
    public let totalCount: UInt32
    public let countOfCameraMarkers: UInt32
    public let countOfComponentMarkers: UInt32
    public let countOfTransitionMarkers: UInt32
    public let countOfImmersionModeMarkers: UInt32

    private enum CodingKeys: String, CodingKey {
        case position
        case boundaryRegion = "boundary_region"
        case totalCount = "total_count"
        case countOfCameraMarkers = "count_of_camera_markers"
        case countOfComponentMarkers = "count_of_component_markers"
        case countOfTransitionMarkers = "count_of_transition_markers"
        case countOfImmersionModeMarkers = "count_of_immersion_mode_markers"
    }
}

/// Request for `POST /v1/maps/markers`.
public struct GetMarkersRequest: Codable, Equatable, Sendable {
    public let mapId: String
    public let entryRegion: EntryRegion?
    public let collapseDistance: Double?

    public init(
        mapId: String,
        entryRegion: EntryRegion? = nil,
        collapseDistance: Double? = nil
    ) {
        self.mapId = mapId
        self.entryRegion = entryRegion
        self.collapseDistance = collapseDistance
    }

    private enum CodingKeys: String, CodingKey {
        case mapId = "map_id"
        case entryRegion = "entry_region"
        case collapseDistance = "collapse_distance"
    }
}

/// Response for `POST /v1/maps/markers`.
public struct GetMarkersResponse: Decodable, Equatable, Sendable {
    public let markers: [String: Marker]
    public let collapsedMarkers: [MarkerGroup]

    private enum CodingKeys: String, CodingKey {
        case markers
        case collapsedMarkers = "collapsed_markers"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        markers = try container.decodeIfPresent([String: Marker].self, forKey: .markers) ?? [:]
        collapsedMarkers = try container.decodeIfPresent([MarkerGroup].self, forKey: .collapsedMarkers) ?? []
    }
}
