// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "flutter_ringtone_player_advanced",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter-ringtone-player-advanced", targets: ["flutter_ringtone_player_advanced"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_ringtone_player_advanced",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: [
            ],
            cSettings: [
                .headerSearchPath("include/flutter_ringtone_player_advanced")
            ]
        )
    ]
)
