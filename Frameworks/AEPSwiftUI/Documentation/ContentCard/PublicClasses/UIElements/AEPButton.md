# AEPButton

The AEPButton class is a fundamental UI component in the AEPSwiftUI framework, used to create interactive buttons within content cards. This class allows you to customize the button with various properties such as the button's text and a custom view modifier. The class conforms to ObservableObject, enabling it to be used reactively in SwiftUI views.

## Public Properties
|Property |	Type |	Description |
| --- | --- | --- |
| text | AEPText |	The text model representing the button's label |
| modifier |	AEPViewModifier? |	A custom view modifier that can be applied to the button view for additional styling |

**Note**: All properties are marked with [@Published](https://developer.apple.com/documentation/combine/published). Any changes will trigger updates to your UI.

## Customization
You can customize the AEPButton properties when working with a template that includes a button. Here's an example:

```swift
class MyCustomizer: ContentCardCustomizing {
    func customize(template: SmallImageTemplate) {
        // Customize the button element
        template.buttons?.first?.text.font = .headline
        template.buttons?.first?.text.textColor = .white
        template.buttons?.first?.modifier = AEPViewModifier(MyButtonModifier())
    }
    
    struct MyButtonModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
```