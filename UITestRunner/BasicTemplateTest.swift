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

final class BasicTemplateTest: XCTestCase {
    
    // This is the notification title and body set in the DemoApp.
    let APS_NOTIFICATION_TITLE = "Notification Title"
    let APS_NOTIFICATION_BODY = "Notification Body"
    
    let app = XCUIApplication()
    
    // Demo App UI Elements
    var userInfoTextField : XCUIElement?
    var triggerNotificationBtn : XCUIElement?
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        // Request notification permission
        addUIInterruptionMonitor(withDescription: "Notification permissions") { (alert) -> Bool in
            alert.buttons["Allow"].tap()
            return true
        }
    }
    

    override func tearDownWithError() throws {
        userInfoTextField?.typeText("")
    }

    func test_happy() throws {
        
        // setup
        let payload = """
        {
            "adb_media": "https://picsum.photos/200",
            "adb_clr_bg": "#FFFFFF",
            "adb_clr_title": "#000000",
            "adb_clr_body": "#AAAAAA",
            "adb_body_ex": "Expanded Body",
            "adb_title_ex": "Expanded Title",
            "adb_template_type": "basic"
        }
        """
        
        // test
        setNotificationUserInfo(payload)
        triggerNotification()
        
                
        // wait for the notification to arrive and finish animation
        sleep(2)
        
        // long press notification
        longPressNotification()


        // verify the content of the expanded notification
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let notificationBanner = springboard.otherElements["notification-expanded-view"].firstMatch
        let basicTemplateTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let basicTemplateDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let basicTemplateImage = notificationBanner.images["AEPNotificationBasicTemplateImage"]

        // verify the existence of UIComponents
        XCTAssert(basicTemplateTitle.waitForExistence(timeout: 7))
        XCTAssert(basicTemplateDescription.exists)
        XCTAssert(basicTemplateImage.exists)
        
        // verify the values
        XCTAssertEqual(basicTemplateTitle.label, "Expanded Title")
        XCTAssertEqual(basicTemplateDescription.label, "Expanded Body")
        XCTAssertGreaterThan(basicTemplateImage.frame.size.height, 0)
    }

    func test_whenExpandedTitle_notAvailable() {
        // setup
        let payload = """
        {
            "adb_media": "https://picsum.photos/200",
            "adb_body_ex": "Expanded Body",
            "adb_template_type": "basic"
        }
        """
        
        // test
        setNotificationUserInfo(payload)
        triggerNotification()

        // wait for the notification to arrive and finish animation
        sleep(2)

        // long press notification
        longPressNotification()
        
        // verify the content of the expanded notification
        let notificationBanner = getNotificationBanner()
        let basicTemplateTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let basicTemplateDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let basicTemplateImage = notificationBanner.images["AEPNotificationBasicTemplateImage"]

        // verify the existence of UIComponents
        XCTAssert(basicTemplateTitle.waitForExistence(timeout: 7))
        XCTAssert(basicTemplateDescription.exists)
        XCTAssert(basicTemplateImage.exists)

        // verify the values
        XCTAssertEqual(basicTemplateTitle.label, APS_NOTIFICATION_TITLE)
        XCTAssertEqual(basicTemplateDescription.label, "Expanded Body")
        XCTAssertGreaterThan(basicTemplateImage.frame.size.height, 0)
    }


    func test_whenExpandedBody_notAvailable() {
        // setup
        let payload = """
        {
            "adb_media": "https://picsum.photos/200",
            "adb_title_ex": "Expanded Title",
            "adb_template_type": "basic",
        }
        """
        
        // test
        setNotificationUserInfo(payload)
        triggerNotification()

        // wait for the notification to arrive and finish animation
        sleep(2)

        // long press notification
        longPressNotification()
        
        // verify the content of the expanded notification
        let notificationBanner = getNotificationBanner()
        let basicTemplateTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let basicTemplateDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let basicTemplateImage = notificationBanner.images["AEPNotificationBasicTemplateImage"]

        // verify the existence of UIComponents
        XCTAssert(basicTemplateTitle.waitForExistence(timeout: 7))
        XCTAssert(basicTemplateDescription.exists)
        XCTAssert(basicTemplateImage.exists)

        // verify the values
        XCTAssertEqual(basicTemplateTitle.label, "Expanded Title")
        XCTAssertEqual(basicTemplateDescription.label, APS_NOTIFICATION_BODY)
        XCTAssertGreaterThan(basicTemplateImage.frame.size.height, 0)
    }

    func test_whenImage_notAvailable() {
        // setup
        let payload = """
        {
            "adb_body_ex": "Expanded Body",
            "adb_title_ex": "Expanded Title",
            "adb_template_type": "basic"
        }
        """
        
        // test
        setNotificationUserInfo(payload)
        triggerNotification()

        // wait for the notification to arrive and finish animation
        sleep(2)

        // long press notification
        longPressNotification()
        
        // verify the content of the expanded notification
        let notificationBanner = getNotificationBanner()
        let basicTemplateTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let basicTemplateDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let basicTemplateImage = notificationBanner.images["AEPNotificationBasicTemplateImage"]

        // verify the existence of UIComponents
        XCTAssert(basicTemplateTitle.waitForExistence(timeout: 7))
        XCTAssert(basicTemplateDescription.exists)
        XCTAssertFalse(basicTemplateImage.exists)

        // verify the values
        XCTAssertEqual(basicTemplateTitle.label, "Expanded Title")
        XCTAssertEqual(basicTemplateDescription.label, "Expanded Body")
    }

    func test_whenNoTitleBodyAndImage() {
        // setup
        let payload = """
        {
            "adb_template_type": "basic"
        }
        """
        
        // test
        setNotificationUserInfo(payload)
        triggerNotification()

        // wait for the notification to arrive and finish animation
        sleep(2)

        // long press notification
        longPressNotification()
        
        // verify the content of the expanded notification
        let notificationBanner = getNotificationBanner()
        let basicTemplateTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let basicTemplateDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]
        let basicTemplateImage = notificationBanner.images["AEPNotificationBasicTemplateImage"]

        // verify the existence of UIComponents
        XCTAssert(basicTemplateTitle.waitForExistence(timeout: 7))
        XCTAssert(basicTemplateDescription.exists)
        XCTAssertFalse(basicTemplateImage.exists)

        // verify the values
        XCTAssertEqual(basicTemplateTitle.label, APS_NOTIFICATION_TITLE)
        XCTAssertEqual(basicTemplateDescription.label, APS_NOTIFICATION_BODY)
    }
    
    
    private func setNotificationUserInfo(_ payload : String) {
        userInfoTextField = app.textViews["txtUserinfo"]
        userInfoTextField?.tap()
        userInfoTextField?.typeText(payload)
    }
    
    private func triggerNotification() {
        triggerNotificationBtn = app.buttons["btnNotification"]
        triggerNotificationBtn?.tap()
    }

    private func longPressNotification(){
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let notificationArea = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        notificationArea.press(forDuration: 1.0)
    }

    private func getNotificationBanner() -> XCUIElement {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        return springboard.otherElements["notification-expanded-view"].firstMatch
    }
}
