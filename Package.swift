// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let resources = "Resources"
let uiStyleKit = "UIStyleKit"
let helpers = "Helpers"
let swiftExtensions = "SwiftExtensions"
let appExtensions = "AppExtensions"
let core = "Core"
let domain = "Domain"
let presentation = "Presentation"

let package = Package(
    name: "BookApp",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: resources, targets: [resources]),
        .library(name: uiStyleKit, targets: [uiStyleKit]),
        .library(name: helpers, targets: [helpers]),
        .library(name: swiftExtensions, targets: [swiftExtensions]),
        .library(name: appExtensions, targets: [appExtensions]),
        .library(name: core, targets: [core]),
        .library(name: domain, targets: [domain]),
        .library(name: presentation, targets: [presentation]),
    ],
    dependencies: [
        // Firebase
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.21.0"),
    ],
    targets: [
        .target(name: resources, resources: [.process("Fonts"), .process("Assets")]),
        .target(name: swiftExtensions),
        .target(
            name: uiStyleKit,
            dependencies: [
                .byName(name: resources),
            ]
        ),
        .target(
            name: helpers,
            dependencies: [
                .byName(name: uiStyleKit),
            ]
        ),
        .target(
            name: appExtensions,
            dependencies: [
                .byName(name: helpers),
            ]
        ),
        .target(
            name: core
        ),
        .target(
            name: domain,
            dependencies: [
                .byName(name: core),
            ]
        ),
        .target(
            name: presentation,
            dependencies: [
                .byName(name: swiftExtensions),
                .byName(name: uiStyleKit),
                .byName(name: appExtensions),
                .byName(name: domain),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk")
            ]
        ),
    ]
)
