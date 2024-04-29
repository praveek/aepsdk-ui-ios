//
// Copyright 2024 Adobe. All rights reserved.
// This file is licensed to you under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License. You may obtain a copy
// of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
// OF ANY KIND, either express or implied. See the License for the specific language
// governing permissions and limitations under the License.
//


import Foundation
import XCTest

final class TimerTemplateTest: AEPXCTestCase {
    
    let EXPIRED_TITLE = "Expired Title"
    let EXPIRED_BODY = "Expired Body"
    let TIMER_DURATION = 5
    
    func test_happy() {
        // setup
        let payload = """
        {
            "adb_media" : "https://picsum.photos/50",
            "adb_title_ex" : "\(EXPANDED_TITLE)",
            "adb_body_ex" : "\(EXPANDED_BODY)",
            "adb_tmr_dur": "\(TIMER_DURATION)",
            "adb_title_alt": "\(EXPIRED_TITLE)",
            "adb_body_alt": "\(EXPIRED_BODY)",
            "adb_media_alt": "https://picsum.photos/50",
            "adb_template_type" : "timer"
        }
      """
      
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyTimerUI(title: EXPANDED_TITLE, description: EXPANDED_BODY, timerExists: true)

        // wait for the notification to expire
        sleep(5)

        // verify the content of the expired notification
        verifyTimerUI(title: EXPIRED_TITLE, description: EXPIRED_BODY)
    }
    
    func test_withEndTimeStamp() {
        // setup
        let payload = """
        {
            "adb_media" : "https://picsum.photos/50",
            "adb_title_ex" : "\(EXPANDED_TITLE)",
            "adb_body_ex" : "\(EXPANDED_BODY)",
            "adb_tmr_end": "\(Date().timeIntervalSince1970 + 15)",
            "adb_title_alt": "\(EXPIRED_TITLE)",
            "adb_body_alt": "\(EXPIRED_BODY)",
            "adb_media_alt": "https://picsum.photos/50",
            "adb_template_type" : "timer"
        }
      """
      
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyTimerUI(title: EXPANDED_TITLE, description: EXPANDED_BODY, timerExists: true)

        // wait for the notification to expire
        sleep(10)

        // verify the content of the expired notification
        verifyTimerUI(title: EXPIRED_TITLE, description: EXPIRED_BODY)
    }

    func test_whenTimerDataNotAvailable() {
        // setup
        let payload = """
        {
            "adb_media" : "https://picsum.photos/50",
            "adb_title_ex" : "\(EXPANDED_TITLE)",
            "adb_body_ex" : "\(EXPANDED_BODY)",
            "adb_title_alt": "\(EXPIRED_TITLE)",
            "adb_body_alt": "\(EXPIRED_BODY)",
            "adb_template_type" : "timer"
        }
      """
      
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyFallbackTemplateShown()
    }

    func test_whenAltTitleNotAvailable() {
        // setup
        let payload = """
        {
            "adb_media" : "https://picsum.photos/50",
            "adb_title_ex" : "\(EXPANDED_TITLE)",
            "adb_body_ex" : "\(EXPANDED_BODY)",
            "adb_tmr_dur": "\(TIMER_DURATION)",
            "adb_body_alt": "\(EXPIRED_BODY)",
            "adb_media_alt": "https://picsum.photos/50",
            "adb_template_type" : "timer"
        }
      """
      
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyFallbackTemplateShown()
    }

    func test_whenExpandedTitleAndBodyAreNotAvailable() {
        // setup
        let payload = """
        {
            "adb_media" : "https://picsum.photos/50",
            "adb_tmr_dur": "\(TIMER_DURATION)",
            "adb_title_alt": "\(EXPIRED_TITLE)",
            "adb_body_alt": "\(EXPIRED_BODY)",
            "adb_media_alt": "https://picsum.photos/50",
            "adb_template_type" : "timer"
        }
      """
      
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyTimerUI(title: APS_NOTIFICATION_TITLE, description: APS_NOTIFICATION_BODY, timerExists: true)
    }

    func test_whenAltBodyNotAvailable() {
        // setup
        let payload = """
        {
            "adb_media" : "https://picsum.photos/50",
            "adb_title_ex" : "\(EXPANDED_TITLE)",
            "adb_body_ex" : "\(EXPANDED_BODY)",
            "adb_tmr_dur": "\(TIMER_DURATION)",
            "adb_title_alt": "\(EXPIRED_TITLE)",
            "adb_media_alt": "https://picsum.photos/50",
            "adb_template_type" : "timer"
        }
      """
      
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        let notificationBanner = getNotificationBanner()
        let timerViewTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let timerViewDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let timerViewTimer = notificationBanner.staticTexts["AEPTimerLabel"]

        // verify the existence of UIComponents
        XCTAssert(timerViewTitle.waitForExistence(timeout: 7))
        XCTAssert(timerViewDescription.exists)
        XCTAssert(timerViewTimer.exists)

        // verify the values
        XCTAssertEqual(timerViewTitle.label, EXPANDED_TITLE)
        XCTAssertEqual(timerViewDescription.label, EXPANDED_BODY)

        // wait for the notification to expire
        sleep(5)

        // verify the content of the expired notification
        XCTAssertEqual(timerViewTitle.label, EXPIRED_TITLE)
        XCTAssertFalse(timerViewDescription.exists)
    }
    
    
    // Helper method to verify UI components and values
    private func verifyTimerUI(title: String, description: String, timerExists: Bool = false, imageExists: Bool = true) {
        let notificationBanner = getNotificationBanner()
        let timerViewTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let timerViewDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let timerViewTimer = notificationBanner.staticTexts["AEPTimerLabel"]
        let timerViewImage = notificationBanner.images["AEPTimerImage"]

        XCTAssert(timerViewTitle.waitForExistence(timeout: 7))
        XCTAssert(timerViewDescription.exists)
        XCTAssertEqual(timerViewTitle.label, title)
        XCTAssertEqual(timerViewDescription.label, description)
        
        if timerExists {
            XCTAssert(timerViewTimer.exists)
        } else {
            XCTAssertFalse(timerViewTimer.exists)
        }
        
        if imageExists {
            XCTAssert(timerViewImage.exists)
        } else {
            XCTAssertFalse(timerViewImage.exists)
        }
    }

}
