# Listening Content Card Events

This tutorial explains how to listen to content card events in your application using the AEPSwiftUI framework.

## Prerequisites
Before proceeding with this tutorial, please read the [Fetch and Display Content Cards](./displaying-content-cards.md) guide.

## Overview
AEPSwiftUI provides a way to listen to events from content cards displayed in your application. You can listen to events such as card display, card click, and card dismiss. This tutorial explains how to listen to these events using the `ContentCardUIEventListening` protocol.

## Implementing ContentCardEventListening
To listen to content card events :
1. Conform to the [ContentCardUIEventListening](../PublicClasses/contentcarduieventlistening.md) protocol in your class or struct.
2. Implement the required methods of the [ContentCardUIEventListening](../PublicClasses/contentcarduieventlistening.md) protocol.
3. Pass the listener to the `getContentCardsUI` API.

Here's an example implementation:

```swift
struct HomePage: View, ContentCardUIEventListening {
    
    @State var savedCards : [ContentCardUI] = []
    
    var body: some View {
        ScrollView (.vertical){
          // Display the content cards here
        }
        .onAppear() {
            let homePageSurface = Surface(path: "homepage")
            // 2. Pass the listener to the getContentCardsUI API
            AEPSwiftUI.getContentCardsUI(for: homePageSurface,
                                         listener: self) { result in
                switch result {
                case .success(let cards):
                    savedCards = cards
                    
                case .failure(let error):
                    // handle error here                    
                }
            }
        }
    }
    
    // Implement the ContentCardUIEventListening protocol methods
    func onDisplay(_ card: ContentCardUI) {
        // Handle the card display event
    }
    
    func onDismiss(_ card: ContentCardUI) {
        // Handle the card dismiss event
    }
    
    func onInteract(_ card: ContentCardUI, _ interactionId: String, actionURL: URL?) -> Bool {
        // Handle the card interaction event
        return false
    }
}
```

### Handling actionable URLs
The `onInteract` method provides an optional actionURL parameter associated with the interaction event. To handle this URL in your application, return true from the onInteract method:

```swift
func onInteract(_ card: ContentCardUI, _ interactionId: String, actionURL: URL?) -> Bool {
    guard let url = actionURL else { return false }
    
    // Handle the actionable URL in your application    
    return true
}
```


### Removing content cards on dismiss
To remove a content card from the UI when the user dismisses it, implement the onDismiss method:

```swift
    func onDismiss(_ card: ContentCardUI) {
        savedCards.removeAll(where: { $0.id == card.id })
    }
```
This implementation ensures that the dismissed card is removed from the savedCards array, which should trigger a UI update if the array is used to populate your view.
