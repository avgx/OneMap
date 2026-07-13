import Foundation
import OneSecurity

extension MapMeta {
    /// Security policy for opening and interacting with this map.
    ///
    /// Combines global role permissions (`user.mapsAccess`) with per-map access
    /// (`access` — server-computed effective access).
    public func viewPolicy(for user: UserSecurityContext) -> MapViewPolicy {
        MapPolicyEvaluator.evaluate(
            user: user,
            objectAccess: access.value ?? .unspecified
        )
    }
}

extension MapFull {
    /// Security policy for this map entry.
    public func viewPolicy(for user: UserSecurityContext) -> MapViewPolicy {
        meta.viewPolicy(for: user)
    }
}
