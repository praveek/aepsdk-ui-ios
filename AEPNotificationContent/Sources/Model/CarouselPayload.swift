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

class CarouselPayload : Payload {
    
    // MARK: - Properties

    /// The mode of the carousel.
    let carouselMode : CarouselMode
    
    /// The layout of the carousel.
    let carouselLayout : CarouselLayout

    /// The items in the carousel.
    var carouselItems: [CarouselItem] = []

    /// Initializes a `CarouselPayload` instance from a `UNNotificationContent`.
    /// Initialization fails if the mandatory properties required for CarouselTemplate are unavailable.
    /// - Parameter notificationContent: The content of the notification.
    required init?(from notificationContent: UNNotificationContent) {
        let userInfo = notificationContent.userInfo
        
        // Retrieve the carousel mode from the notification
        // If the mode is not available, default to auto
        if let carModeString = userInfo[AEPNotificationContentConstants.PayloadKey.Carousel.MODE] as? String,
           let mode = CarouselMode(rawValue: carModeString) {
            carouselMode = mode
        } else {
            carouselMode = .auto
        }
        
        // Retrieve the carousel layout from the notification
        // If the layout is not available, default to defaultLayout
        if let carLayoutString = userInfo[AEPNotificationContentConstants.PayloadKey.Carousel.LAYOUT] as? String,
           let layout = CarouselLayout(rawValue: carLayoutString) {
            carouselLayout = layout
        } else {
            carouselLayout = .defaultLayout
        }
        
        // Retrieve the carousel items from the notification
        // If valid imageURL's are not available for any of the Carousel item, Fail initialization
        if let itemsArray = userInfo[AEPNotificationContentConstants.PayloadKey.Carousel.ITEMS] as? [[String: Any]] {
            for itemDict in itemsArray {
                if let carouselItem = CarouselItem(dictionary: itemDict, notificationContent: notificationContent) {
                    self.carouselItems.append(carouselItem)
                } else {
                    return nil // Fails initialization if any item doesn't have a valid "image" URL
                }
            }
        } else {
            return nil
        }
        
        super.init(notificationContent: notificationContent)
    }
}

// Enum for Carousel Mode
enum CarouselMode: String {
    case manual = "manual"
    case auto = "auto"
}

// Enum for Carousel Layout
enum CarouselLayout: String {
    case filmstrip = "filmstrip"
    case defaultLayout = "default" // 'default' is a reserved keyword in Swift
}
