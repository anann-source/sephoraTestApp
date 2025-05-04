// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductListingPage",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ProductListingPage",
            targets: ["ProductListingPage"]),
    ],
    dependencies: [
            .package(path: "../SharedCore/DesignSystem"),
            .package(path: "../SharedCore/Networking"),
            .package(path: "../SharedCore/Persistance")
    ],
    targets: [
        .target(
            name: "ProductListingPage", dependencies: ["DesignSystem", "Networking", "Persistance"]), // Tout le code source doit etre dans ce dossier ProductListingPage
        .testTarget(
            name: "ProductListingPageTests",
            dependencies: ["ProductListingPage"]
        ),
    ]
)
