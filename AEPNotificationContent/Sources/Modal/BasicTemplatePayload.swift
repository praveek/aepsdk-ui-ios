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
import UserNotifications
import UIKit

/// A structure representing the basic payload extracted from a notification.
struct BasicTemplatePayload {
    
    private let defaultBackgroundColor = UIColor.white
    private let defaultTitleColor = UIColor.black
    private let defaultDescriptionColor = UIColor.darkGray
    
    /// The URL of the image associated with the basic template notification.
    let imageURL: String
    
    /// The background color of the notification.
    var backgroundColor: UIColor
    
    /// The title and description text, along with their respective colors.
    var titleDescriptionPayload: TitleDescriptionPayload
    
    /// Initializes a `BasicPayload` instance from a `UNNotificationContent`.
    /// - Parameter notificationContent: The content of the notification.
    init?(from notificationContent: UNNotificationContent) {
        // Extract image URL from the notification, return nil if not found.
        guard let imageURL = notificationContent.userInfo[AEPNotificationContentConstants.PayloadKey.Basic.IMAGE_URL] as? String else {
            print("ImageURL is not found. BasicTemplatePayload cannot be created.")
            return nil
        }
        
        // Retrieve the title and expanded description text.
        let titleText = notificationContent.title
        let descriptionText = Self.expandedDescription(from: notificationContent)
        
        // Extract and set the background color.
        backgroundColor = Self.extractColor(from: notificationContent,
                                            key: AEPNotificationContentConstants.PayloadKey.BACKGROUND_COLOR,
                                            defaultColor: defaultBackgroundColor)
        
        // Extract and set the title and description colors.
        let titleColor = Self.extractColor(from: notificationContent,
                                           key: AEPNotificationContentConstants.PayloadKey.TITLE_COLOR,
                                           defaultColor: defaultTitleColor)
        let descriptionColor = Self.extractColor(from: notificationContent,
                                                 key: AEPNotificationContentConstants.PayloadKey.BODY_COLOR,
                                                 defaultColor: defaultDescriptionColor)
        
        // Initialize properties.
        self.imageURL = imageURL
        self.titleDescriptionPayload = TitleDescriptionPayload(title: titleText,
                                                               description: descriptionText,
                                                               titleColor: titleColor,
                                                               descriptionColor: descriptionColor)
    }

    /// Extracts and returns the expanded description from notification content.
    /// - Parameter notificationContent: The notification content to extract from.
    /// - Returns: The expanded description text.
    private static func expandedDescription(from notificationContent: UNNotificationContent) -> String {
        let defaultDescription = notificationContent.body
        return notificationContent.userInfo[AEPNotificationContentConstants.PayloadKey.Basic.EXPANDED_BODY_TXT] as? String ?? defaultDescription
    }

    /// Extracts and returns a color from notification content for a specific key.
    /// - Parameters:
    ///   - notificationContent: The notification content to extract from.
    ///   - key: The key for the color information.
    ///   - defaultColor: The default color to return if extraction fails.
    /// - Returns: The extracted color or the default color.
    private static func extractColor(from notificationContent: UNNotificationContent, key: String, defaultColor: UIColor) -> UIColor {
        if let colorString = notificationContent.userInfo[key] as? String, let color = UIColor(hexString: colorString) {
            return color
        }
        return defaultColor
    }
}
