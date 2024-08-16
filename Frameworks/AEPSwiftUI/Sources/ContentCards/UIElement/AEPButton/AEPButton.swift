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

import SwiftUI

// The model class representing the button UI element of the ContentCard.
public class AEPButton: ObservableObject, AEPViewModel {
    @Published public var text: AEPText
    @Published public var interactId: String
    @Published public var actionUrl: String?

    public lazy var view: some View = AEPButtonView(model: self)

    /// Initializes a new instance of `AEPButton`
    /// Failable initializer, returns nil if the required fields are not present in the data
    /// - Parameter data: The dictionary containing server side styling and content of the button
    public init?(_ data: [String: Any]) {
        // Extract the button text
        // Bail out if the button text is not present
        guard let buttonTextData = data[Constants.CardTemplate.UIElement.Button.TEXT] as? [String: Any],
              let buttonText = AEPText(buttonTextData) else {
            return nil
        }

        // Extract the interactId
        // Bail out if the interact Id is not present
        guard let interactId = data[Constants.CardTemplate.UIElement.Button.INTERACTION_ID] as? String else {
            return nil
        }

        self.text = buttonText
        self.interactId = interactId
        self.actionUrl = data[Constants.CardTemplate.UIElement.Button.ACTION_URL] as? String
    }
}
