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

import XCTest

final class BasicTemplateTest: AEPXCTestCase {

    func test_happy() throws {        
        // setup
        let payload = """
        {
            "adb_media": "https://picsum.photos/200",
            "adb_clr_bg": "#FFFFFF",
            "adb_clr_title": "#000000",
            "adb_clr_body": "#AAAAAA",
            "adb_title_ex": "\(EXPANDED_TITLE)",
            "adb_body_ex": "\(EXPANDED_BODY)",
            "adb_template_type": "basic"
        }
        """
        
        // test
        triggerAndOpenNotification(payload)

        // verify the content of the expanded notification
        verifyBasicUI(title: EXPANDED_TITLE, description: EXPANDED_BODY, imageExists: true)
    }

    func test_whenExpandedTitle_notAvailable() {
        // setup
        let payload = """
        {
            "adb_media": "https://picsum.photos/200",
            "adb_body_ex": "\(EXPANDED_BODY)",
            "adb_template_type": "basic"
        }
        """
        
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyBasicUI(title: APS_NOTIFICATION_TITLE, description: EXPANDED_BODY, imageExists: true)
    }

    func test_whenExpandedBody_notAvailable() {
        // setup
        let payload = """
        {
            "adb_media": "https://picsum.photos/200",
            "adb_title_ex": "\(EXPANDED_TITLE)",
            "adb_template_type": "basic",
        }
        """
        
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyBasicUI(title: EXPANDED_TITLE, description: APS_NOTIFICATION_BODY, imageExists: true)
    }

    func test_whenImage_notAvailable() {
        // setup
        let payload = """
        {
            "adb_title_ex": "\(EXPANDED_TITLE)",
            "adb_body_ex": "\(EXPANDED_BODY)",
            "adb_template_type": "basic"
        }
        """
        
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyBasicUI(title: EXPANDED_TITLE, description: EXPANDED_BODY, imageExists: false)
    }

    func test_whenNoTitleBodyAndImage() {
        // setup
        let payload = """
        {
            "adb_template_type": "basic"
        }
        """
        
        // test
        triggerAndOpenNotification(payload)
        
        // verify the content of the expanded notification
        verifyBasicUI(title: APS_NOTIFICATION_TITLE, description: APS_NOTIFICATION_BODY, imageExists: false)
    }
    
    
    // Helper method to verify UI components and values
    private func verifyBasicUI(title: String, description: String, imageExists: Bool = true) {
        let notificationBanner = getNotificationBanner()
        let basicViewTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let basicViewDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let basicViewImage = notificationBanner.images["AEPBasicTemplateImage"]

        XCTAssert(basicViewTitle.waitForExistence(timeout: 7))
        XCTAssert(basicViewDescription.exists)
        XCTAssertEqual(basicViewTitle.label, title)
        XCTAssertEqual(basicViewDescription.label, description)
        
        if imageExists {
            XCTAssert(basicViewImage.exists)
            XCTAssertGreaterThan(basicViewImage.frame.size.height, 0)
        } else {
            XCTAssertFalse(basicViewImage.exists)
        }
    }

}
