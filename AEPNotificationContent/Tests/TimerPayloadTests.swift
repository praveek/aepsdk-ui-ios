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
@testable import AEPNotificationContent

final class TimerPayloadTests: XCTestCase {
    
    func testInitWithValidPayload() {
        // setup
        let content = UNMutableNotificationContent()
        content.userInfo = [
            "adb_media" : "https://www.adobe.com/image0.jpg",
            "adb_tmr_dur": "10",
            "adb_title_alt": "alternate title",
            "adb_body_ex_alt": "alternate body",
            "adb_media_alt": "https://www.adobe.com/image1.jpg"
        ]
                
        // test
        let timerPayload = TimerPayload(from: content, notificationDate: Date())
        
        // verify
        XCTAssertNotNil(timerPayload)
        XCTAssertNotNil(timerPayload?.expiryTime)
        XCTAssertEqual(timerPayload?.alternateTitle, "alternate title")
        XCTAssertEqual(timerPayload?.alternateBody, "alternate body")
        XCTAssertEqual(timerPayload?.alternateImageURL, URL(string: "https://www.adobe.com/image1.jpg"))
    }

    func testInitWithoutAlternateImageURL() {
        // setup
        let content = UNMutableNotificationContent()
        content.userInfo = [
            "adb_media" : "https://www.adobe.com/image0.jpg",
            "adb_tmr_dur": "10",
            "adb_title_alt": "alternate title",
            "adb_body_ex_alt": "alternate body"
        ]
                
        // test
        let timerPayload = TimerPayload(from: content, notificationDate: Date())
        
        // verify
        XCTAssertNil(timerPayload)
    }

    func testInitWithoutExpiryTime() {
        // setup
        let content = UNMutableNotificationContent()
        content.userInfo = [
            "adb_media" : "https://www.adobe.com/image0.jpg",
            "adb_title_alt": "alternate title",
            "adb_body_ex_alt": "alternate body",
            "adb_media_alt": "https://www.adobe.com/image1.jpg"
        ]
                
        // test
        let timerPayload = TimerPayload(from: content, notificationDate: Date())
        
        // verify
        XCTAssertNil(timerPayload)
    }

    func testInitWithoutAlternateBody() {
        // setup
        let content = UNMutableNotificationContent()
        content.userInfo = [
            "adb_media" : "https://www.adobe.com/image0.jpg",
            "adb_tmr_dur": "10",
            "adb_title_alt": "alternate title",
            "adb_media_alt": "https://www.adobe.com/image1.jpg"
        ]
                
        // test
        let timerPayload = TimerPayload(from: content, notificationDate: Date())
        
        // verify
        XCTAssertNotNil(timerPayload)
        XCTAssertEqual(timerPayload?.alternateTitle, "alternate title")
    }

    func testInitWithoutAlternateTitle() {
        // setup
        let content = UNMutableNotificationContent()
        content.userInfo = [
            "adb_media" : "https://www.adobe.com/image0.jpg",
            "adb_tmr_dur": "10",
            "adb_body_ex_alt": "alternate body",
            "adb_media_alt": "https://www.adobe.com/image1.jpg"
        ]
                
        // test
        let timerPayload = TimerPayload(from: content, notificationDate: Date())
        
        // verify
        XCTAssertNotNil(timerPayload)
        XCTAssertEqual(timerPayload?.alternateBody, "alternate body")
    }

    func testInitWithTimerDuration() {
        // setup
        let content = UNMutableNotificationContent()
        content.userInfo = [
            "adb_media" : "https://www.adobe.com/image0.jpg",
            "adb_tmr_dur": "10",
            "adb_title_alt": "alternate title",
            "adb_body_ex_alt": "alternate body",
            "adb_media_alt": "https://www.adobe.com/image1.jpg"
        ]
                
        // test
        let timerPayload = TimerPayload(from: content, notificationDate: Date())
        
        // verify
        XCTAssertNotNil(timerPayload)
        XCTAssertEqual(timerPayload!.expiryTime, Date().timeIntervalSince1970 + 10, accuracy: 2.0)
    }

    func testInitWithEndTimestamp() {
        // setup
        let content = UNMutableNotificationContent()
        content.userInfo = [
            "adb_media" : "https://www.adobe.com/image0.jpg",
            "adb_tmr_end": "1712417524",
            "adb_title_alt": "alternate title",
            "adb_body_ex_alt": "alternate body",
            "adb_media_alt": "https://www.adobe.com/image1.jpg"
        ]
                
        // test
        let timerPayload = TimerPayload(from: content, notificationDate: Date())
        
        // verify
        XCTAssertNotNil(timerPayload)
        XCTAssertEqual(timerPayload!.expiryTime, 1712417524)
    }
    
}
