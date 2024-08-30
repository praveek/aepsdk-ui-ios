# AEPImage

The AEPImage class is a fudamental UI component in the AEPSwiftUI framework, used to display images for content cards. This class allows you to display images from various sources (URL, bundle, or SF Symbols) and customize their appearance. It conforms to ObservableObject, enabling reactive updates in SwiftUI views.

## Image Sources
The AEPImage class supports multiple sources for displaying images, with built-in support for both light and dark mode variants. The sources are prioritized in the following order:
- URL images
- Bundled Resource images
- SF Symbol icons

## Public properties

| Property | Type | Description | Default Value |
| --- | --- | --- | --- |
| contentMode | ContentMode | The content mode of the image.|[ContentMode.fit](https://developer.apple.com/documentation/swiftui/contentmode/fit)
| modifier | AEPViewModifier | A custom view modifer that can be applied to the text view for additional styling | N/A  |
| icon | String |	The name of the SF Symbol icon used in the image. <br> *This applies only to images sourced from icons.* |	N/A |
| iconFont |	Font |	The font of the SF Symbol icon used in the image. <br> *This applies to images sourced from icons.* |	N/A |
| iconColor |	Color |	The color of the SF Symbol icon used in the image. <br> *This applies to images sourced from icons.* | [primary](https://developer.apple.com/documentation/swiftui/color/primary) |

**Note**: All properties are marked with [@Published](https://developer.apple.com/documentation/combine/published). Any changes will trigger updates to your UI.


## Customization
You can customize the AEPImage properties when working with a template that includes an image. Here's an example:

```swift
class MyCustomizer: ContentCardCustomizing {
    func customize(template: SmallImageTemplate) {
        // Customize the image element
        template.image.contentMode = .fill
        template.image.modifier = AEPViewModifier(MyImageModifier())

        // Customize the dismiss button
        // dismiss buttons are images sourced from SF Symbols icons
        template.dismissButton?.image.iconName = "xmark" // SF Symbol name
        template.dismissButton?.image.iconColor = .primary
        template.dismissButton?.image.iconFont = .system(size: 10)        
    }
    
    struct MyImageModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.red, lineWidth: 2))
        }
    }
}
```