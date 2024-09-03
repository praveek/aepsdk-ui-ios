# Getting started with AEPSwiftUI framework

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

> During BETA, you will need to point to the specific beta release tag in the repo.

```ruby
# Podfile
use_frameworks!

# for app development, include all the following pods
target 'YOUR_APP_NAME' do
    pod 'AEPSwiftUI', :git => 'https://github.com/adobe/aepsdk-ui-ios.git', :tag => '5.1.0-beta'
end
```

Replace `YOUR_APP_NAME` and then, in the `Podfile` directory, run:

```ruby
$ pod install
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Not available during the BETA.

### Binaries

To generate `AEPSwiftUI.xcframework`, run the following command from the root directory:

```
make archive
```

This will generate an XCFramework under the `build` folder. Drag and drop `AEPSwiftUI.xcframework` to your app's target in Xcode.