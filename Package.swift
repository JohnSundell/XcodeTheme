// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "XcodeTheme",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "4.0.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "XcodeTheme", dependencies: ["Files", "ShellOut"])
    ]
)
