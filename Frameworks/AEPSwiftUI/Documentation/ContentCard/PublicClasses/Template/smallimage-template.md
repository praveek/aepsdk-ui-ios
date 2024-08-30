# SmallImageTemplate
 
 This class represents SmallImage content card template defined by Adobe Journey Optimizer. In this template, the image is displayed in line with the text content. The template includes a title, body, image, and a maximum of three buttons. The template also includes an optional dismiss button to dismiss the content card. Use this class to customize the appearance of the SmallImage content card template. The class conforms to ObservableObject, enabling it to be used reactively in SwiftUI views.

## Layout
<img src="../../../Assets/smallimagetemplate-layout.png" width="500">

## Public Properties

| Property      | Type                                                        | Description                                                              |
| ------------- | ----------------------------------------------------------- | ------------------------------------------------------------------------ |
| title         | [AEPText](../UIElements/aeptext.md)                          | The title of the template.                                               |
| body          | [AEPText](../UIElements/aeptext.md)                          | *Optional*<br>The body of the template.                                  |
| image         | [AEPImage](../UIElements/aepimage.md)                        | *Optional*<br>The image associated with the template.                    |
| buttons       | [[AEPButton](../UIElements/aepbutton.md)]                    | *Optional*<br>The list of buttons for the template.                      |
| buttonHStack  | [AEPHStack](../UIElements/aepstack.md)                       | A horizontal stack for arranging buttons.                                |
| textVStack    | [AEPVStack](../UIElements/aepstack.md)                       | A vertical stack for arranging the title, body, and buttons.             |
| rootHStack    | [AEPHStack](../UIElements/aepstack.md)                       | A horizontal stack for arranging the image and text stack.               |
| dismissButton | [AEPButton](../UIElements/aepdismissbutton.md)                      | *Optional*<br>The dismiss button for the template.                       |