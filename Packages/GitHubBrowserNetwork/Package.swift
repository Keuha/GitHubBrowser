// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitHubBrowserNetwork",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "GitHubBrowserNetwork",
            targets: ["GitHubBrowserNetwork"]),
    ],
    targets: [
        .target(
            name: "GitHubBrowserNetwork"),
        .testTarget(
            name: "GitHubBrowserNetworkTests",
            dependencies: ["GitHubBrowserNetwork"]),
    ]
)
