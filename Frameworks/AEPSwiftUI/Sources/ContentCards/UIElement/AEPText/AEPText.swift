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
import SwiftUI

// The model class representing the text UI element of the ContentCard.
public class AEPText: ObservableObject, AEPViewModel {
    // The content of the text
    @Published public var content: String

    // The font of the text
    @Published public var font: Font?

    // The color of the text
    @Published public var textColor: Color?

    /// The SwiftUI view of the text
    public lazy var view: some View = AEPTextView(model: self)

    /// Initializes a new instance of `AEPText`
    /// Failable initializer, returns nil if the required fields are not present in the data
    /// - Parameter data: The dictionary containing server side styling and content of the text
    public init?(_ data: [String: Any]) {
        guard let content = data[Constants.CardTemplate.UIElement.Text.CONTENT] as? String, !content.isEmpty else {
            return nil
        }
        self.content = content

        // TODO: - Extract font and textColor from data
        // Not required for Phase 1 (Since we only allow client side customization)
    }
}
