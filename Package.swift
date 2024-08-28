// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

/*
 Copyright 2024 Adobe. All rights reserved.
 This file is licensed to you under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License. You may obtain a copy
 of the License at http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software distributed under
 the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
 OF ANY KIND, either express or implied. See the License for the specific language
 governing permissions and limitations under the License.
 */

import PackageDescription

let package = Package(
    name: "AEPUI",
    products: [
        .package(path: "Frameworks/AEPNotificationContent"),
        .package(path: "Frameworks/AEPSwiftUI")
    ]
)

// let package = Package(
//     name: "AEPUI",
//     platforms: [.iOS(.v15)],
//     products: [
//         .library(name: "AEPNotificationContent", targets: ["AEPNotificationContent"]),
//         .library(name: "AEPSwiftUI", targets: ["AEPSwiftUI"])
//     ],
//     dependencies: [
//         .package(url: "https://github.com/adobe/aepsdk-core-ios.git", .upToNextMajor(from: "5.2.0")),
//         .package(url: "https://github.com/adobe/aepsdk-messaging-ios.git", .upToNextMajor(from: "5.0.0")),
//         .package(url: "https://github.com/adobe/aepsdk-edge-ios.git", .upToNextMajor(from: "5.0.2")),
//         .package(url: "https://github.com/adobe/aepsdk-edgeidentity-ios.git", .upToNextMajor(from: "5.0.0"))
//     ],
//     targets: [
//         .target(name: "AEPNotificationContent",
//                 path: "Frameworks/AEPNotificationContent/Sources"),
//         .target(name: "AEPSwiftUI",
//                 dependencies: [
//                     .product(name: "AEPCore", package: "aepsdk-core-ios"),
//                     .product(name: "AEPServices", package: "aepsdk-core-ios"),
//                     .product(name: "AEPMessaging", package: "aepsdk-messaging-ios"),
//                     .product(name: "AEPEdge", package: "aepsdk-edge-ios"),
//                     .product(name: "AEPEdgeIdentity", package: "aepsdk-edgeidentity-ios")
//                 ],
//                 path: "Frameworks/AEPSwiftUI/Sources")
//     ]
// )
