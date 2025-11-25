// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.7
// swift-tools-version: 6.1
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "GamificationPackage",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "GamificationPackage",
            targets: ["GamificationPackage"]
        ) 
    ],
    dependencies: [
        .package(
            url: "https://github.com/Hkashif722/NetworkManager.git",
            branch: "development_branch"
        )
    ],
    targets: [
        .target(
            name: "GamificationPackage",
            dependencies: [
                .product(name: "NetworkService", package: "NetworkManager")
            ],
            resources: [
                .process("Resources/Fonts")
            ]
        ),
        .testTarget(
            name: "GamificationPackageTests",
            dependencies: [
                "GamificationPackage",
                .product(name: "NetworkService", package: "NetworkManager")
            ]
        )
    ]
)
