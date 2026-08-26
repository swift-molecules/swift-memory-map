// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-memory-map",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Memory Map",
            targets: ["Memory Map"]
        ),
        .library(
            name: "Memory Map Test Support",
            targets: ["Memory Map Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-memory.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-lock.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-error.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-span.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Memory Map",
            dependencies: [
                .product(name: "Memory Address", package: "swift-memory"),
                .product(name: "Memory Lock", package: "swift-memory-lock"),
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "Error", package: "swift-error"),
                .product(name: "Span Protocol", package: "swift-span"),
            ]
        ),
        .target(
            name: "Memory Map Test Support",
            dependencies: [
                "Memory Map",
                .product(
                    name: "Memory Test Support",
                    package: "swift-memory"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Memory Map Tests",
            dependencies: [
                "Memory Map"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = [
        .enableExperimentalFeature("RawLayout")
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
