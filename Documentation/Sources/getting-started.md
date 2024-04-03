#  Getting started with AEPNotificationContent extension

### Prerequisites

Make sure you have completed the steps in the [prerequisites](./prerequisites.md)

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

# for app development, include all the following pods
target 'YOUR_NOTIFICATION_CONTENT_EXTENSION_NAME' do
      pod 'AEPNotificationContent', :git => 'https://github.com/adobe/aepsdk-notificationcontent-ios.git', :branch => 'dev-v5.0.0'      
end
```

Replace `YOUR_NOTIFICATION_CONTENT_EXTENSION_NAME` and then, in the `Podfile` directory, type:

```ruby
$ pod install
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

To add the AEPNotificationContent Package to your application, from the Xcode menu select:

`File > Add Packages...`

> **Note**: the menu options may vary depending on the version of Xcode being used.

Enter the URL for the AEPNotificationContent package repository: `https://github.com/adobe/aepsdk-notificationcontent-ios.git`.

For `Dependency Rule`, select `Up to Next Major Version`.

Alternatively, if your project has a `Package.swift` file, you can add the AEPNotificationContent extension directly to your dependencies:

```
dependencies: [
    .package(name: "AEPNotificationContent", url: "https://github.com/adobe/aepsdk-notificationcontent-ios.git", .upToNextMajor(from: "5.0.0"))
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "AEPNotificationContent", package: "AEPNotificationContent")
        ]
    )
]
```

### Binaries

To generate `AEPNotificationContent.xcframework`, run the following command from the root directory:

```
make archive
```

This will generate an XCFramework under the `build` folder. Drag and drop `AEPNotificationContent.xcframework` to your app target.

### Do stuff in your extension
