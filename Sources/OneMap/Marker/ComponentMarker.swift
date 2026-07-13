import Foundation
import SafeEnum

/// Empty marker payloads for simple component types.
public struct RelayMarker: Codable, Equatable, Sendable {}
public struct SensorMarker: Codable, Equatable, Sendable {}
public struct MicrophoneMarker: Codable, Equatable, Sendable {}
public struct SpeakerMarker: Codable, Equatable, Sendable {}
public struct ImmersionModeMarker: Codable, Equatable, Sendable {}

/// Polyline geometry for device-node markers.
public struct PolylineData: Codable, Equatable, Sendable {
    public let points: [Point3D]
    public let closed: Bool

    private enum CodingKeys: String, CodingKey {
        case points
        case closed
    }
}

/// Device-node marker details.
public struct DeviceNodeMarker: Codable, Equatable, Sendable {
    public let points: PolylineData
    public let visualKeys: [String]
    public let drawingMode: SafeEnum<DeviceNodeDrawingMode>

    private enum CodingKeys: String, CodingKey {
        case points
        case visualKeys = "visual_keys"
        case drawingMode = "drawing_mode"
    }
}

/// Component marker subtype payload.
public struct ComponentMarkerDetails: Codable, Equatable, Sendable {
    public let parentComponentName: String
    public let pinnedTo: String
    public let pinnedToEdge: SafeEnum<PinEdge>
    public let pinToCameraIndex: Int
    public let distance: Int
    public let relayMarker: RelayMarker?
    public let sensorMarker: SensorMarker?
    public let deviceNodeMarker: DeviceNodeMarker?
    public let microphoneMarker: MicrophoneMarker?
    public let speakerMarker: SpeakerMarker?

    private enum CodingKeys: String, CodingKey {
        case parentComponentName = "parent_component_name"
        case pinnedTo = "pinned_to"
        case pinnedToEdge = "pinned_to_edge"
        case pinToCameraIndex = "pin_to_camera_index"
        case distance
        case relayMarker = "relay_marker"
        case sensorMarker = "sensor_marker"
        case deviceNodeMarker = "device_node_marker"
        case microphoneMarker = "microphone_marker"
        case speakerMarker = "speaker_marker"
    }
}

/// Transition marker details.
public struct TransitionMarker: Codable, Equatable, Sendable {
    public let linkedMapId: String

    private enum CodingKeys: String, CodingKey {
        case linkedMapId = "linked_map_id"
    }
}

/// Macro marker details.
public struct MacroMarker: Codable, Equatable, Sendable {
    public let showButtons: Bool

    private enum CodingKeys: String, CodingKey {
        case showButtons = "show_buttons"
    }
}

/// Counter marker details.
public struct CounterMarker: Codable, Equatable, Sendable {
    public let points: PolylineData
    public let color: String?

    private enum CodingKeys: String, CodingKey {
        case points
        case color
    }
}
