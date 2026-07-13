import Foundation

/// View mode options for domain cameras.
public enum MapViewMode: String, Codable, Equatable, Sendable {
    /// Include only map meta info
    case VIEW_MODE_ONLY_META = "VIEW_MODE_ONLY_META"
    /// Full map information
    case VIEW_MODE_FULL = "VIEW_MODE_FULL"
}
