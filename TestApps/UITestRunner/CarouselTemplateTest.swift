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

class CarouselTemplateTest : AEPXCTestCase {
    
    let CAROUSEL_BODY_0 = "CarouselBody0"
    let CAROUSEL_BODY_1 = "CarouselBody1"
    let CAROUSEL_BODY_2 = "CarouselBody2"
    
    func test_happy() throws {
        
        // setup
        let payload = """
        {
        "adb_media": "https://example.com/image.png",
        "adb_title_ex": "\(EXPANDED_TITLE)",
        "adb_body_ex": "\(EXPANDED_BODY)",
        "adb_car_mode": "manual",
        "adb_template_type": "car",
        "adb_items": [
            {
                "img": "https://picsum.photos/50/25",
                "txt": "\(CAROUSEL_BODY_0)",
                "uri": "ht1tps://adobe.com"
            },
            {
                "img": "https://picsum.photos/100/50",
                "txt": "\(CAROUSEL_BODY_1)"
            },
            {
                "img": "https://picsum.photos/50/100",
                "txt": "\(CAROUSEL_BODY_2)",
                "uri": "https://adobe.com"
            }
        ]
        }
        """
        
        // test
        triggerAndOpenNotification(payload)

        // verify the content of the expanded notification
        verifyCarouselItem(index: 0, title: EXPANDED_TITLE, description: CAROUSEL_BODY_0)

        //  next carousel item
        rightArrowClicked()
        
        // verify the values of second carousel item
        verifyCarouselItem(index: 1, title: EXPANDED_TITLE, description: CAROUSEL_BODY_1)
        
        //  next carousel item
        rightArrowClicked()
        
        // verify the values of third carousel item
        verifyCarouselItem(index: 2, title: EXPANDED_TITLE, description: CAROUSEL_BODY_2)
        
        
        //  previous carousel item
        leftArrowClicked()
        
        // verify the values of second carousel item
        verifyCarouselItem(index: 1, title: EXPANDED_TITLE, description: CAROUSEL_BODY_1)
        
        //  previous carousel item
        leftArrowClicked()
        
        // verify the values of third carousel item
        verifyCarouselItem(index: 0, title: EXPANDED_TITLE, description: CAROUSEL_BODY_0)
    }

    func test_swiping_carouselItems() throws {
        
        // setup
        let payload = """
        {
        "adb_media": "https://example.com/image.png",
        "adb_title_ex": "\(EXPANDED_TITLE)",
        "adb_body_ex": "\(EXPANDED_BODY)",
        "adb_car_mode": "manual",
        "adb_template_type": "car",
        "adb_items": [
            {
                "img": "https://picsum.photos/50/25",
                "txt": "\(CAROUSEL_BODY_0)",
                "uri": "ht1tps://adobe.com"
            },
            {
                "img": "https://picsum.photos/100/50",
                "txt": "\(CAROUSEL_BODY_1)"
            }
        ]
        }
        """
        
        // test
        triggerAndOpenNotification(payload)
        
        // Swipe to next item
        swipeLeft()

        // verify the values of second carousel item
        verifyCarouselItem(index: 1, title: EXPANDED_TITLE, description: CAROUSEL_BODY_1)

        // Swipe to previous item
        swipeRight()

        // verify the values of first carousel item
        verifyCarouselItem(index: 0, title: EXPANDED_TITLE, description: CAROUSEL_BODY_0)
    }

    func test_whenExpandedTitleAndBodyAreNotAvailable() throws {
        
        // setup
        let payload = """
        {
        "adb_media": "https://example.com/image.png",
        "adb_car_mode": "manual",
        "adb_template_type": "car",
        "adb_items": [
            {
                "img": "https://picsum.photos/50/25",
                "txt": "\(CAROUSEL_BODY_0)",
                "uri": "ht1tps://adobe.com"
            },
            {
                "img": "https://picsum.photos/100/50",
                "txt": "\(CAROUSEL_BODY_1)"
            }
        ]
        }
        """
        
        // test
        triggerAndOpenNotification(payload)

        // verify the content of the expanded notification
        verifyCarouselItem(index: 0, title: APS_NOTIFICATION_TITLE, description: CAROUSEL_BODY_0)
    }

    func test_whenCarouselItemsAreNotAvailable() throws {
        
        // setup
        let payload = """
        {
        "adb_media": "https://example.com/image.png",
        "adb_title_ex": "\(EXPANDED_TITLE)",
        "adb_car_mode": "manual",
        "adb_template_type": "car"
        }
        """
        
        // test
        triggerAndOpenNotification(payload)

        // verify the content of the expanded notification
        verifyFallbackTemplateShown()
    }

    func test_whenCarouselItemHasNoImage() throws {
        
        // setup
        let payload = """
        {
        "adb_media": "https://example.com/image.png",
        "adb_title_ex": "\(EXPANDED_TITLE)",
        "adb_body_ex": "\(EXPANDED_BODY)",
        "adb_car_mode": "manual",
        "adb_template_type": "car",
        "adb_items": [
            {
                "txt": "\(CAROUSEL_BODY_0)",
                "uri": "ht1tps://adobe.com"
            },
            {
                "img": "https://picsum.photos/100/50",
                "txt": "\(CAROUSEL_BODY_1)"
            },
            {
                "img": "https://picsum.photos/50/100",
                "txt": "\(CAROUSEL_BODY_2)",
                "uri": "https://adobe.com"
            }
        ]
        }
        """
        
        // test
        triggerAndOpenNotification(payload)
        
        //  verify first carousel item is ignored
        verifyCarouselItem(index: 0, title: EXPANDED_TITLE, description: CAROUSEL_BODY_1)
        
        //  next carousel item
        rightArrowClicked()
        
        // verify third carousel item is displayed
        verifyCarouselItem(index: 1, title: EXPANDED_TITLE, description: CAROUSEL_BODY_2)
    }

    func test_withOnlyOneCarouselItem() throws {
        
        // setup
        let payload = """
        {
        "adb_media": "https://example.com/image.png",
        "adb_title_ex": "\(EXPANDED_TITLE)",
        "adb_body_ex": "\(EXPANDED_BODY)",
        "adb_car_mode": "manual",
        "adb_template_type": "car",
        "adb_items": [
            {
                "img": "https://picsum.photos/50/25",
                "txt": "\(CAROUSEL_BODY_0)",
                "uri": "ht1tps://adobe.com"
            }
        ]
        }
        """
        
        // test
        triggerAndOpenNotification(payload)

        // verify the content of the expanded notification
        verifyCarouselItem(index: 0, title: EXPANDED_TITLE, description: CAROUSEL_BODY_0)
        verifyRightAndLeftArrowDoesNotExist()

    }

    func test_whenCarouselItemHasNoText() throws {
        
        // setup
        let payload = """
        {
        "adb_media": "https://example.com/image.png",
        "adb_title_ex": "\(EXPANDED_TITLE)",
        "adb_body_ex": "\(EXPANDED_BODY)",
        "adb_car_mode": "manual",
        "adb_template_type": "car",
        "adb_items": [
            {
                "img": "https://picsum.photos/50/25",
                "uri": "ht1tps://adobe.com"
            },
            {
                "img": "https://picsum.photos/100/50",
                "txt": "\(CAROUSEL_BODY_1)"
            }
        ]
        }
        """
        
        // test
        triggerAndOpenNotification(payload)

        // verify the content of the expanded notification
        verifyCarouselItem(index: 0, title: EXPANDED_TITLE, description: APS_NOTIFICATION_BODY)
        
        // move to next item
        rightArrowClicked()
        
        // verify the content of second carousel item
        verifyCarouselItem(index: 1, title: EXPANDED_TITLE, description: CAROUSEL_BODY_1)
    }

    private func swipeLeft() {
        let notificationBanner = getNotificationBanner()
        let carouselView = notificationBanner.scrollViews["AEPScrollView"]
        carouselView.swipeLeft()
        sleep(1)
    }

    private func swipeRight() {
        let notificationBanner = getNotificationBanner()
        let carouselView = notificationBanner.scrollViews["AEPScrollView"]
        carouselView.swipeRight()
        sleep(1)
    }
    
    private func rightArrowClicked() {
        let notificationBanner = getNotificationBanner()
        let rightArrow = notificationBanner.buttons["AEPCarouselRightArrow"]
        rightArrow.tap()
        sleep(1)
    }

    private func leftArrowClicked() {
        let notificationBanner = getNotificationBanner()
        let leftArrow = notificationBanner.buttons["AEPCarouselLeftArrow"]
        leftArrow.tap()
        sleep(1)
    }

    private func verifyRightAndLeftArrowDoesNotExist() {
        let notificationBanner = getNotificationBanner()
        let rightArrow = notificationBanner.buttons["AEPCarouselRightArrow"]
        let leftArrow = notificationBanner.buttons["AEPCarouselLeftArrow"]
        XCTAssertFalse(rightArrow.exists)
        XCTAssertFalse(leftArrow.exists)
    }

    
    private func getCarouselImage(atIndex index : Int) -> XCUIElement {
        return getScrollView().images["AEPCarouselImage\(index)"]
    }
    
    private func getScrollView() -> XCUIElement {
        let notificationBanner = getNotificationBanner()
        return notificationBanner.scrollViews["AEPScrollView"]
    }
    
    private func verifyCarouselItem(index: Int, title: String, description: String) {
        let notificationBanner = getNotificationBanner()
        let carouselTitle = notificationBanner.staticTexts["AEPNotificationContentTitle"]
        let carouselDescription = notificationBanner.staticTexts["AEPNotificationContentDescription"]

        XCTAssert(carouselTitle.waitForExistence(timeout: 7))
        XCTAssert(carouselDescription.exists)
        XCTAssertEqual(carouselTitle.label, title)
        XCTAssertEqual(carouselDescription.label, description)
        verifyCarouselImage(atIndex: index)
    }
    
    private func verifyCarouselImage(atIndex index: Int) {
        XCTAssertTrue(getScrollView().exists)
        let carouselImage = getScrollView().images["AEPCarouselImage\(index)"]
        XCTAssertTrue(carouselImage.exists)
        XCTAssertGreaterThan(carouselImage.frame.size.height, 0)
    }
}
