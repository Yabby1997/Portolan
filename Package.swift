// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Portolan",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Portolan",
            targets: ["Portolan"]
        ),
    ],
    targets: [
        .target(
            name: "Portolan",
            path: "Portolan"
        )
    ]
)
