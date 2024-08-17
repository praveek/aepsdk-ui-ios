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
import XCTest
@testable import AEPSwiftUI
@testable import AEPMessaging

final class ContentCardSchemaDataTests: XCTestCase {
    
    let smallImageSchema = ContentCardTestUtil.createContentCardSchemaData(fromFile: "SmallImageTemplate")
    let emptySchema = ContentCardSchemaData.getEmpty()

    func test_contentDict() {
        XCTAssertNil(emptySchema.contentDict)
        XCTAssertNotNil(smallImageSchema.contentDict)
    }

    func test_metaAdobeData() {
        XCTAssertNil(emptySchema.metaAdobeData)
        XCTAssertNotNil(smallImageSchema.metaAdobeData)
    }

    func test_templateType() {
        XCTAssertEqual(emptySchema.templateType, .unknown)
        XCTAssertEqual(smallImageSchema.templateType, .smallImage)
    }

    func test_titleExtraction() {
        XCTAssertNil(emptySchema.title)
        let title = smallImageSchema.title
        XCTAssertNotNil(title)
        XCTAssertEqual(title?.content, "Card Title")
    }

    func test_bodyExtraction() {
        XCTAssertNil(emptySchema.body)
        let body = smallImageSchema.body
        XCTAssertNotNil(body)
        XCTAssertEqual(body?.content, "Card Body")
    }
    
    func test_imageExtraction() {
        XCTAssertNil(emptySchema.image)
        let image = smallImageSchema.image
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.url?.absoluteString, "https://imagetoDownload.com/cardimage")
    }
    
    func test_buttonsExtraction() {
        XCTAssertNil(emptySchema.buttons)
        let buttons = smallImageSchema.buttons
        XCTAssertNotNil(buttons)
        XCTAssertEqual(buttons?.count, 2)
        
        // verify each button
        XCTAssertEqual(buttons?[0].interactId, "purchaseID")
        XCTAssertEqual(buttons?[1].interactId, "cancelID")
    }

    func test_actionUrlExtraction() {
        XCTAssertNil(emptySchema.actionUrl)
        let actionUrl = smallImageSchema.actionUrl
        XCTAssertNotNil(actionUrl)
        XCTAssertEqual(actionUrl?.absoluteString, "https://actionUrl.com")
    }

}

