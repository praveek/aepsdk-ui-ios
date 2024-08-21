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
import AEPServices
import Foundation
import SwiftUI

/// ContentCardUI is a class that holds data for a content card and provides a SwiftUI view representation of that content.
public class ContentCardUI: Identifiable {
    /// The underlying data model for the content card.
    let schemaData: ContentCardSchemaData

    public let template: any ContentCardTemplate

    /// SwiftUI view that represents the content card
    public lazy var view: some View = {
        // TODO: Make adjustments to remove AnyView
        AnyView(template.view)
    }()

    /// Factory method to create a `ContentCardUI` instance based on the provided schema data.
    /// - Parameter schemaData: The `ContentCardSchemaData` to be used for the content
    /// - Returns: An initialized `ContentCardUI` instance, or `nil` if unable to create template from `schemaData`
    static func createInstance(with schemaData: ContentCardSchemaData) -> ContentCardUI? {
        // determine the appropriate template based on the template type
        let template: (any ContentCardTemplate)? = {
            switch schemaData.templateType {
            case .smallImage:
                return SmallImageTemplate(schemaData)
            case .largeImage, .imageOnly, .unknown:
                // Currently unsupported template types
                return nil
            }
        }()

        // ensure a valid template is created
        guard let validTemplate = template else {
            return nil
        }

        // Initialize the ContentCardUI with the schema data and template
        let contentCardUI = ContentCardUI(schemaData, validTemplate)

        // set the listener for the template
        validTemplate.eventHandler = contentCardUI
        return contentCardUI
    }

    /// Initializes a new `ContentCardUI` instance with the given schema data and template.
    /// - Parameters:
    ///   - schemaData: The `ContentCardSchemaData` to be used for the content card.
    ///   - template: The template that defines the content card's layout and behavior.
    ///
    /// - Note : This initializer is private to ensure that `ContentCardUI` instances are only created through the `createInstance` factory method.
    private init(_ schemaData: ContentCardSchemaData, _ template: any ContentCardTemplate) {
        self.schemaData = schemaData
        self.template = template
    }
}
