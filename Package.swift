// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "BluffXcodes",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .executable(
      name: "bluffxcodes",
      targets: ["bluffxcodes"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
    .package(url: "https://github.com/mxcl/Version", from: "2.1.0"),
    .package(url: "https://github.com/pakLebah/ANSITerminal", from: "0.0.3")

  ],
  targets: [
    .executableTarget(
      name: "bluffxcodes",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "Version",
        "ANSITerminal"
      ],
      path: "Sources"
    )
  ]
)
