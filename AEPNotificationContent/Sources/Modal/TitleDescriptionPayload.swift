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

// Struct representing the title and description payload
// It contains all the necessary information to display a titleDescriptionView
struct TitleDescriptionPayload {
    
    /// Color constants
    enum DefaultColor {
        static let TITLE = UIColor.black
        static let DESCRIPTION = UIColor.darkGray
    }
        
    let title : String
    let description : String
    var titleColor : UIColor
    var descriptionColor : UIColor
    
    init(title: String, description: String,
         titleColor: UIColor = DefaultColor.TITLE, descriptionColor: UIColor = DefaultColor.DESCRIPTION) {
        self.title = title
        self.description = description
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
    }

}
