// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GPGKit",
    products: [
        .library(
            name: "GPGKit",
            targets: ["GPGKit"]
        ),
    ],
    targets: [
        .systemLibrary(
            name: "gpgme",
            pkgConfig: "gpgme",
            providers: [
                .brew(["gpgme"])
            ]
        ),
        .target(name: "GPGKit", dependencies: ["gpgme"]),
    ]
)
