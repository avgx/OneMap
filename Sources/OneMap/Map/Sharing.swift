import Foundation
import SafeEnum

/// Map sharing settings.
public struct Sharing: Codable, Equatable, Sendable {
    public let owner: String
    public let kind: SafeEnum<SharingKind>
    public let sharedRoles: [String]

    private enum CodingKeys: String, CodingKey {
        case owner
        case kind
        case sharedRoles = "shared_roles"
    }
}
