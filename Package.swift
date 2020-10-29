// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BBSwift",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .watchOS(.v6)
    ], products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "BBSwift",
            targets: ["BBSwift", "BBSwiftScroll"]),
        .library(
            name: "BBSwiftWatch",
            targets: ["BBSwift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect", from: "0.1.0"),
        .package(name: "Gloss", url: "https://github.com/hkellaway/Gloss", from: "3.1.0"),
        .package(name: "CryptoSwift", url: "https://github.com/krzyzanowskim/CryptoSwift", from: "1.3.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "BBSwift", dependencies: [
            "Gloss", "CryptoSwift"
        ]),
        .target(name: "BBSwiftScroll", dependencies: [
            "Introspect"
        ]),
    ]
)
