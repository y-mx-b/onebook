// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "onebook",
    platforms: [
        .macOS(.v10_13)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.2"),
        .package(url: "https://github.com/luardemin/BookmarkParser", .branch("master")),
        // .package(url: "https://github.com/dduan/TOMLDecoder", from: "0.2.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "onebook",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "BookmarkParser", package: "BookmarkParser"),
                // .product(name: "TOMLDecoder", package: "TOMLDecoder")
            ]),
        .testTarget(
            name: "onebookTests",
            dependencies: ["onebook"]),
    ]
)
