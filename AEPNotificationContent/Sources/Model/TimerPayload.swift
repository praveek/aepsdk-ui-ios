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

class TimerPayload: Payload {
    // MARK: - Properties

    /// The image URL for the timer expired view
    var alternateImageURL: URL

    /// The color of the timer text
    var timerColor: UIColor

    /// The duration of the timer
    var expiryTime: TimeInterval

    /// titleBody of non-expired timer template view
    lazy var titleBodyPayload: TitleBodyPayload = {
        let title = notificationContent.expandedTitle ?? notificationContent.title
        let body = expandedBody ?? ""
        return TitleBodyPayload(title: title, body: body)
    }()

    /// titleBody for expired timer template view
    lazy var altTitleBodyPayload: TitleBodyPayload = {
        let title = notificationContent.alternateTitle ?? notificationContent.title
        let body = notificationContent.alternateBody ?? ""
        return TitleBodyPayload(title: title, body: body)
    }()

    /// Initializes a `TimerPayload` instance from a `UNNotificationContent`.
    /// Initialization fails if the mandatory properties required for TimerTemplate are unavailable
    /// - Parameter notification: The content of the notification.
    required init?(from notificationContent: UNNotificationContent, notificationDate: Date) {
        // Extract the alternate image data and fast fail if alternateImage URL is not available
        guard let alternateImageURL = notificationContent.alternateImageURL else {
            return nil
        }
        self.alternateImageURL = alternateImageURL

        // Extract the timer data from the notification
        guard let expiryTime = Self.extractExpiryTime(notificationContent, notificationDate) else {
            return nil
        }
        self.expiryTime = expiryTime

        // Extract the color of the timer text color from the notification
        self.timerColor = notificationContent.timerColor

        super.init(notificationContent: notificationContent)
        // If the imageUrl or alternate image url not available in the notification, bail out
        guard let _ = imageURL else {
            return nil
        }
    }

    /// Extracts the timer information from the notification content
    /// - Parameter notificationContent: The content of the notification
    private static func extractExpiryTime(_ content: UNNotificationContent, _ notificationDate: Date) -> (TimeInterval)? {
        if let duration = content.timerDuration {
            return notificationDate.timeIntervalSince1970 + duration
        } else if let endTimestamp = content.endTimestamp {
            return endTimestamp
        }
        return nil
    }
}
