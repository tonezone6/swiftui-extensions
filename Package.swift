// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftUIExtensions",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "SwiftUIExtensions",
      targets: ["SwiftUIExtensions"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "SwiftUIExtensions",
      dependencies: [],
      path: "Sources"
    )
  ]
)
