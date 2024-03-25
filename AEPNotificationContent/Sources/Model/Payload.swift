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
import UserNotifications


// A class that extracts and loads the base properties for building push templates
class Payload {
    
    /// Default color constants
    enum DefaultColor {
        static let background = UIColor.white
        static let title = UIColor.black
        static let description = UIColor.darkGray
    }
    
    // MARK: Public properties

    /// The image URL for the notification.
    let imageURL: URL?
    
    /// The click URL for the notification.
    let clickURL : URL?
    
    /// The content of the notification.
    let notificationContent: UNNotificationContent
    
    /// The title color for the expanded view.
    let titleColor : UIColor
    
    /// The description color for the expanded view.
    let descriptionColor : UIColor
    
    /// The background color of the notification.
    var backgroundColor: UIColor
    
    /// The description text for the expanded view
    var expandedDescription: String?
        
    // MARK: - Initialization
    
    /// Initializes a `BasicPayload` instance from a `UNNotificationContent`.
    /// Initialization fails if the mandatory properties required for BasicTemplate are unavailable
    /// - Parameter notificationContent: The content of the notification.
    init(notificationContent: UNNotificationContent) {
        self.notificationContent = notificationContent
        
        // Extract image URL from the notification
        if let imageURLString = notificationContent.userInfo[AEPNotificationContentConstants.PayloadKey.IMAGE_URL] as? String,
           let imageURL = URL(string: imageURLString) {
            self.imageURL = imageURL
        } else {
            imageURL = nil
        }
        
        
        // Extract click URL from the notification
        if let clickURLString = notificationContent.userInfo[AEPNotificationContentConstants.PayloadKey.CLICK_URL] as? String,
           let clickURL = URL(string: clickURLString) {
            self.clickURL = clickURL
        } else {
            clickURL = nil
        }
        
        expandedDescription = Self.expandedDescription(from: notificationContent)
        
        // Extract and set the background color.
        backgroundColor = Self.extractColor(from: notificationContent,
                                            key: AEPNotificationContentConstants.PayloadKey.BACKGROUND_COLOR,
                                            defaultColor: DefaultColor.background)
        
        // Extract and set the title and description colors.
        titleColor = Self.extractColor(from: notificationContent,
                                           key: AEPNotificationContentConstants.PayloadKey.TITLE_COLOR,
                                           defaultColor: DefaultColor.title)
        descriptionColor = Self.extractColor(from: notificationContent,
                                                 key: AEPNotificationContentConstants.PayloadKey.BODY_COLOR,
                                                 defaultColor: DefaultColor.description)
    }

    // MARK: - Private methods
    
    /// Extracts and returns the expanded description from notification content.
    /// - Parameter notificationContent: The notification content to extract from.
    /// - Returns: The expanded description text.
    private static func expandedDescription(from notificationContent: UNNotificationContent) -> String? {
        return notificationContent.userInfo[AEPNotificationContentConstants.PayloadKey.Basic.EXPANDED_BODY_TXT] as? String
    }

    /// Extracts and returns a color from notification content for a specific key.
    /// - Parameters:
    ///   - notificationContent: The notification content to extract from.
    ///   - key: The key for the color information.
    ///   - defaultColor: The default color to return if extraction fails.
    /// - Returns: The extracted color or the default color.
    static func extractColor(from notificationContent: UNNotificationContent, key: String, defaultColor: UIColor) -> UIColor {
        if let colorString = notificationContent.userInfo[key] as? String, let color = UIColor(hexString: colorString) {
            return color
        }
        return defaultColor
    }
}
