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

import AEPMessaging
import SwiftUI

/// A class representing a content card template with a small image layout.
///
/// `SmallImageTemplate` is a subclass of `BaseTemplate` and conforms to the `ContentCardTemplate` protocol.
/// It provides a structured layout for content cards that include a small image, title, body, and optional buttons.
/// This class is initialized with `ContentCardSchemaData`, which is used to populate the template's properties.
/// If the required `title` is missing from the schema data, the initialization fails.
///
/// - Note: The `view` property is lazily initialized and represents the entire layout of the content card.
public class SmallImageTemplate: BaseTemplate, ContentCardTemplate {
    var templateType: ContentCardTemplateType = .smallImage

    /// The title of the content card.
    var title: AEPText

    /// The body text of the content card, if available.
    var body: AEPText?

    /// The image associated with the content card, if available.
    var image: AEPImage?

    /// The buttons associated with the content card, if available.
    var buttons: [AEPButton]?

    /// A horizontal stack for arranging buttons.
    var buttonHStack = AEPHStack()

    /// A vertical stack for arranging the title, body, and buttons.
    var textVStack = AEPVStack()

    /// A horizontal stack for arranging the image and text stack.
    var rootHStack = AEPHStack()

    /// The SwiftUI view representing the content card.
    public lazy var view: some View = buildCardView {
        rootHStack.view
    }

    /// Initializes a `SmallImageTemplate` with the given schema data.
    ///
    /// This initializer extracts the title, body, image, and buttons from the provided `ContentCardSchemaData`.
    /// It organizes these components into the appropriate stacks to form the small Image layout.
    ///
    /// - Parameter schemaData: The schema data used to populate the template's properties.
    /// - Returns: An initialized `SmallImageTemplate` or `nil` if the required title is missing.
    override init?(_ schemaData: ContentCardSchemaData) {
        guard let title = schemaData.title else {
            return nil
        }
        self.title = title
        super.init(schemaData)
        
        self.body = schemaData.body
        self.image = schemaData.image
        self.buttons = schemaData.buttons(forTemplate: self)
        
        // Add buttons to buttonHStack
        if let buttons = buttons {
            for button in buttons {
                buttonHStack.addModel(button)
            }
        }

        // Add title, body, and buttonHStack to textVStack
        textVStack.addModel(title)
        if let body = body {
            textVStack.addModel(body)
        }
        textVStack.addModel(buttonHStack)

        // Add image and textVStack to rootHStack
        if let image = image {
            rootHStack.addModel(image)
        }
        rootHStack.addModel(textVStack)
    }
}
