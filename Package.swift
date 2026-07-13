// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "OneMap",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "OneMap",
            targets: ["OneMap"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/avgx/OneSecurity", from: "1.0.3"),
        .package(url: "https://github.com/avgx/RequestResponse", from: "2.0.1"),
        .package(url: "https://github.com/avgx/SafeEnum", from: "1.0.0"),
        .package(url: "https://github.com/avgx/EncodeDecode", from: "1.0.5"),
        .package(url: "https://github.com/avgx/OneWireFormat", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "OneMap",
            dependencies: [
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "SafeEnum", package: "SafeEnum"),
                .product(name: "OneWireFormat", package: "OneWireFormat"),
                .product(name: "OneSecurity", package: "OneSecurity"),
            ]
        ),
        .testTarget(
            name: "OneMapTests",
            dependencies: [
                "OneMap",
                "OneSecurity",
                .product(name: "EncodeDecode", package: "EncodeDecode"),
            ],
            resources: [.process("Resources")]
        ),
    ]
)
