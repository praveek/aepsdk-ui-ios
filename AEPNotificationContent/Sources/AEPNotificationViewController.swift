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

import UIKit
import UserNotifications
import UserNotificationsUI

open class AEPNotificationViewController: UIViewController, UNNotificationContentExtension {
    
    /// This method is called in the main thread of the notification content app extension
    public func didReceive(_ notification: UNNotification) {
        guard let payload = notification.request.content.userInfo as? [String: AnyObject],
              let template = payload[AEPNotificationContentConstants.PayloadKey.TEMPLATE_TYPE] as? String
        else {
            displayFallbackTemplate(notification)
            return
        }

        switch template {
        case AEPNotificationContentConstants.PayloadKey.TemplateType.BASIC:
            if let payload = BasicPayload(from: notification.request.content) {
                let basicTemplateController = BasicTemplateController(payload)
                view.addSubview(basicTemplateController.view)
                preferredContentSize.height = basicTemplateController.preferredContentSize.height
            } else {
                displayFallbackTemplate(notification)
            }
        case AEPNotificationContentConstants.PayloadKey.TemplateType.CAROUSEL:
            print("//TODO: Create and display Carousel viewController")
        case AEPNotificationContentConstants.PayloadKey.TemplateType.TIMER:
            print("//TODO: Create and display Timer viewController")
        default:
            displayFallbackTemplate(notification)
        }
    }

    public func didReceive(_: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    open override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        preferredContentSize.height = container.preferredContentSize.height
    }

    private func displayFallbackTemplate(_ notification: UNNotification) {
        let fallback = FallbackTemplateController(notification: notification)
        view.addSubview(fallback.view)
        preferredContentSize.height = fallback.preferredContentSize.height
    }
}
