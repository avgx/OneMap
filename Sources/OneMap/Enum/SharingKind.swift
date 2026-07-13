import Foundation

/// Map sharing scope.
public enum SharingKind: String, Codable, Hashable, Sendable {
    case any = "SHARING_KIND_ANY"
    case specificRoles = "SHARING_KIND_SPECIFIC_ROLES"
    case notShared = "SHARING_KIND_NOT_SHARED"
}
