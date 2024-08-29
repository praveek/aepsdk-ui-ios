# Adobe Experience Platform - AEPSwiftUI library for iOS - BETA

# BETA NOTICE

This project is currently in beta status. Support provided by this library, including but not limited to functionality and public APIs, may be modified prior to the general availability release.

## About this project

Adobe Experience Platform (AEP) Swift UI library contains reusable SwiftUI components for use with the [Adobe Experience Platform Swift SDK](https://github.com/adobe/aepsdk-core-ios).

The SwiftUI components provided in this library enable the following workflows:

* Delivering content cards to users

    * Content cards are authored and managed in [Adobe Journey Optimizer](https://business.adobe.com/products/journey-optimizer/adobe-journey-optimizer.html) and retrieved in your app with help from the [AEP Messaging extension](https://github.com/adobe/aepsdk-messaging-ios).

## Requirements

- iOS 15 (or newer)
- Xcode 15 (or newer)
- Swift 5.1 (or newer)

## Getting started

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

> During BETA, an additional line of configuration is necessary to retrieve the correct BETA version of the Messaging extension. After the general availability release, this dependency will be automatically managed by `AEPSwiftUI.podspec`.

```ruby
# Podfile
use_frameworks!

# for app development, include all the following pods
target 'YOUR_NOTIFICATION_CONTENT_EXTENSION_NAME' do
    pod 'AEPSwiftUI', :git => 'https://github.com/adobe/aepsdk-ui-ios.git', :tag => '5.1.0-beta'
    pod 'AEPMessaging', :git => 'https://github.com/adobe/aepsdk-messaging-ios.git', :tag => '5.3.0-beta'
end
```

Replace `YOUR_NOTIFICATION_CONTENT_EXTENSION_NAME` and then, in the `Podfile` directory, run:

```ruby
$ pod install
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Not available during the BETA.

### Binaries

To generate `AEPSwiftUI.xcframework`, run the following command from the root directory:

```
make archive-aep-swift-ui
```

This will generate an XCFramework under the `build` folder. Drag and drop `AEPSwiftUI.xcframework` to your app's target in Xcode.

## Contributing

Looking to contribute to this project? Please review our [contributing guidelines](../../.github/CONTRIBUTING.md) prior to opening a pull request.

We look forward to working with you!

## Licensing

This project is licensed under the Apache V2 License. See [LICENSE](../../LICENSE) for more information.
