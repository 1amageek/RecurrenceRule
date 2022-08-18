// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RecurrenceRule",
    products: [
        .library(
            name: "RecurrenceRule",
            targets: ["RecurrenceRule"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RecurrenceRule",
            dependencies: []),
        .testTarget(
            name: "RecurrenceRuleTests",
            dependencies: ["RecurrenceRule"]),
    ]
)
