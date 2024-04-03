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

import Foundation
import UIKit

/// Class representing a Carousel Item
class CarouselItem {
    // MARK: - Properties

    /// The URL to the item's image.
    let imageURL: URL
    /// The URL to open when the item is clicked (optional).
    var clickURL: URL?
    /// The image data (will be attached after download).
    var image: UIImage?
    /// The title and body text associated with the item.
    let titleBodyPayload: TitleBodyPayload

    // MARK: - Initialization

    /// Initializes a `CarouselItem` instance from a dictionary.
    /// - Parameters:
    ///   - dictionary: A dictionary containing the carousel item data.
    ///   - notificationContent: The UNNotificationContent object.
    /// - Returns: A `CarouselItem` instance if the dictionary contains valid data, `nil` otherwise.
    init?(dictionary: [String: Any], notificationContent: UNNotificationContent) {
        /// Fail initialization if we are unable to obtain a valid imageURL from the given dictionary
        guard let imageString = dictionary[AEPNotificationContentConstants.PayloadKey.Carousel.IMAGE] as? String,
              let imageURL = URL(string: imageString) else {
            return nil
        }
        self.imageURL = imageURL

        /// Set carousel items title and body text
        /// Carousel Item title is same as the notification title
        /// Set the Carousel Item body text if available, otherwise set it to an empty string
        let bodyTxt = dictionary[AEPNotificationContentConstants.PayloadKey.Carousel.TEXT] as? String ?? ""
        self.titleBodyPayload = TitleBodyPayload(title: notificationContent.title, body: bodyTxt)

        /// Set the click URL if available and valid, nil otherwise
        if let clickURLString = dictionary[AEPNotificationContentConstants.PayloadKey.Carousel.URI] as? String {
            self.clickURL = URL(string: clickURLString)
        }
    }
}
