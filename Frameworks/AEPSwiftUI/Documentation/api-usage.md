# APIs Usage

This document provides information on how to use the AEPSwiftUI APIs to receive and display content card views in your application.

## Importing AEPSwiftUI

To use the AEPSwiftUI APIs, you need to import the AEPSwiftUI module in your Swift file.

###### Swift
```swift
import AEPSwiftUI
```

## APIs

### extensionVersion

The `extensionVersion` property is used to get the version of the AEPSwiftUI extension.

##### Example
```swift
let version = AEPSwiftUI.extensionVersion
```

### getContentCardUI 

The getContentCardUI method retrieves a list of [ContentCardUI](ContentCard/PublicClasses/contentcardui.md) objects for a specified surface. These ContentCardUI objects provide the user interface for templated content cards in your application.

##### Parameters:
**surface**: The surface for which the content cards should be retrieved.

**customizer**: An optional [ContentCardCustomizing](ContentCard/PublicClasses/contentcardcustomizing.md) object to customize the appearance of the content card template. If you do not need to customize the appearance of the content card template, this parameter can be omitted.

**listener**: An optional [ContentCardUIEventListening](ContentCard/PublicClasses/contentcarduieventlistening.md) object to listen to UI events from the content card. If you do not need to listen to UI events from the content card, this parameter can be omitted.

**completion**: : A completion handler that is called with a Result type containing either:
- success: An array of [ContentCardUI](ContentCard/PublicClasses/contentcardui.md) objects representing the content cards to be displayed.
- failure: An Error object indicating the reason for the failure, if any.

> **Note**: You must call `updatePropositionsForSurfaces` API from Messaging extension with the required surfaces before calling this API. This API call will not download the content cards from AJO. It will only retrieve the content cards that are already downloaded and cached with Messaging extension's updateProposition API.

##### Syntax

```swift
public static func getContentCardsUI(for surface: Surface,
                                     customizer: ContentCardCustomizing? = nil,
                                     listener: ContentCardUIEventListening? = nil,
                                     _ completion: @escaping (Result<[ContentCardUI], Error>) -> Void)
```

##### Example

```swift
// Dowload the content cards for homepage surface using Messaging extension
let homePageSurface = Surface(path: "homepage")
Messaging.updatePropositionsForSurfaces([homePageSurface])

// Get the content card UI for the homepage surface
let homePageSurface = Surface(path: "homepage")
AEPSwiftUI.getContentCardUI(surface: homePageSurface, customizer: nil, listener: nil) { result in
    switch result {
    case .success(let contentCards):
        // Use the contentCards array to display UI for templated content cards in your application
    case .failure(let error):
        // Handle the error
    }
}
```