// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RevolutionRoboticsBluetooth",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RevolutionRoboticsBluetooth",
            targets: ["RevolutionRoboticsBluetooth"])
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.4.3")
    ],
    targets: [
        .target(
            name: "RevolutionRoboticsBluetooth",
            dependencies: [
                "CryptoSwift"
            ],
            path: "RevolutionRoboticsBluetooth/Classes")
    ]
)
