import Foundation
import OneSecurity
import Testing
@testable import OneMap

@Suite("Map view policy")
struct MapViewPolicyTests {
    private let viewOnlyUser = UserSecurityContext(
        isUnrestricted: false,
        prohibitAny: false,
        forceWatermark: false,
        defaultCameraAccess: .monitoring,
        mapsAccess: .viewOnly,
        featureAccess: [],
        alertAccess: .forbid
    )

    private let fullUser = UserSecurityContext(
        isUnrestricted: false,
        prohibitAny: false,
        forceWatermark: false,
        defaultCameraAccess: .full,
        mapsAccess: .full,
        featureAccess: [],
        alertAccess: .forbid
    )

    @Test("unspecified object inherits global maps access")
    func unspecifiedInheritsGlobal() {
        let policy = MapPolicyEvaluator.evaluate(
            user: viewOnlyUser,
            objectAccess: .unspecified
        )
        #expect(policy.canOpen)
        #expect(policy.canView)
        #expect(!policy.canScale)
        #expect(!policy.canEdit)
    }

    @Test("forbid blocks map surfaces")
    func forbidBlocks() {
        let policy = MapPolicyEvaluator.evaluate(
            user: fullUser,
            objectAccess: .forbid
        )
        #expect(!policy.canOpen)
        #expect(!policy.canView)
        #expect(policy.denialReason == .accessForbidden)
    }

    @Test("full access allows edit")
    func fullAccess() throws {
        let map = try FixtureLoader.firstMap(resource: "v1_maps_list_raster")
        let policy = map.viewPolicy(for: fullUser)
        #expect(policy.canOpen)
        #expect(policy.canView)
        #expect(policy.canScale)
        #expect(policy.canEdit)
    }

    @Test("unrestricted bypasses forbid")
    func unrestrictedBypass() {
        let user = UserSecurityContext(
            isUnrestricted: true,
            prohibitAny: false,
            forceWatermark: false,
            defaultCameraAccess: .forbid,
            mapsAccess: .forbid,
            featureAccess: [],
            alertAccess: .forbid
        )
        let policy = MapPolicyEvaluator.evaluate(
            user: user,
            objectAccess: .forbid
        )
        #expect(policy.canOpen)
        #expect(policy.canEdit)
    }
}
