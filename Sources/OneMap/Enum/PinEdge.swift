import Foundation

/// Edge of a component to which a marker is pinned.
public enum PinEdge: String, Codable, Hashable, Sendable {
    case none = "PIN_EDGE_NONE"
    case left = "PIN_EDGE_LEFT"
    case top = "PIN_EDGE_TOP"
    case right = "PIN_EDGE_RIGHT"
    case bottom = "PIN_EDGE_BOTTOM"
}
