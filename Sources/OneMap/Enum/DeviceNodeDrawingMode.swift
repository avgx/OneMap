import Foundation

/// How a device-node marker is drawn on the map.
public enum DeviceNodeDrawingMode: String, Codable, Hashable, Sendable {
    case normal = "NORMAL"
    case openUnderMouse = "OPEN_UNDER_MOUSE"
    case alwaysOpen = "ALWAYS_OPEN"
}
