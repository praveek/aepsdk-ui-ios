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

/// An extension of `ContentCardSchemaData` that provides methods and computed variables for extracting
/// specific data elements from the content card schema.
extension ContentCardSchemaData {
    /// A dictionary representing the content of the content card.
    var contentDict: [String: Any]? {
        self.content as? [String: Any]
    }

    /// A dictionary representing the Adobe-specific metadata of the content card.
    var metaAdobeData: [String: Any]? {
        self.meta?[Constants.CardTemplate.SchemaData.Meta.ADOBE_DATA] as? [String: Any]
    }

    /// The template type of the content card.
    /// This property extracts the template type from the Adobe-specific metadata and converts it to
    /// a `ContentCardTemplateType` value. If the template type cannot be determined, it defaults to `.unknown`.
    var templateType: ContentCardTemplateType {
        guard let templateString = self.metaAdobeData?[Constants.CardTemplate.SchemaData.Meta.TEMPLATE] as? String else {
            return .unknown
        }
        return ContentCardTemplateType(from: templateString)
    }

    /// This property extracts the title data from the content dictionary and attempts to
    /// initialize an `AEPText` object with it. Returns `nil` if the title data is not available.
    var title: AEPText? {
        guard let titleData = self.contentDict?[Constants.CardTemplate.SchemaData.TITLE] as? [String: Any] else {
            return nil
        }

        return AEPText(titleData)
    }

    /// This property extracts the body data from the content dictionary and attempts to
    /// initialize an `AEPText` object with it. Returns `nil` if the body data is not available.
    var body: AEPText? {
        guard let bodyData = self.contentDict?[Constants.CardTemplate.SchemaData.BODY] as? [String: Any] else {
            return nil
        }
        return AEPText(bodyData)
    }

    /// This property extracts the image data from the content dictionary and attempts to
    /// initialize an `AEPText` object with it. Returns `nil` if the image data is not available.
    var image: AEPImage? {
        guard let imageData = self.contentDict?[Constants.CardTemplate.SchemaData.IMAGE] as? [String: Any] else {
            return nil
        }
        return AEPImage(imageData)
    }

    /// This property extracts the array of button  from the content dictionary and attempts to
    /// initialize an `AEPText` object with it. Returns `nil` if the buttons data is not available.
    var buttons: [AEPButton]? {
        guard let buttonsData = self.contentDict?[Constants.CardTemplate.SchemaData.BUTTONS] as? [[String: Any]] else {
            return nil
        }
        return buttonsData.compactMap { AEPButton($0) }
    }

    /// This property extracts the action URL from the content dictionary and returns it as a URL object.
    /// Returns `nil` if the action URL is not available or if it is not a valid URL.
    var actionUrl: URL? {
        guard let actionUrl = self.contentDict?[Constants.CardTemplate.SchemaData.ACTION_URL] as? String else {
            return nil
        }
        return URL(string: actionUrl)
    }
}
