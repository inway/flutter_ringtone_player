// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "flutter_ringtone_player",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter-ringtone-player", targets: ["flutter_ringtone_player"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_ringtone_player",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: [
            ],
            cSettings: [
                .headerSearchPath("include/flutter_ringtone_player")
            ]
        )
    ]
)
