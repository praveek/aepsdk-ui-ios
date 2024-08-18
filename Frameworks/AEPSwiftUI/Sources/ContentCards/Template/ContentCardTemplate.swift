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

/// A protocol defining the requirements for content card templates.
protocol ContentCardTemplate: BaseTemplate {
    associatedtype Content: View

    /// The type of the content card template.
    var templateType: ContentCardTemplateType { get }

    /// The SwiftUI view representing the content of the template.
    var view: Self.Content { get }
}

extension ContentCardTemplate {
    /// Returns the final SwiftUI view for the content card, with an optional background color.
    ///
    /// This method returns the view associated with the content card template, applying
    /// all the common properties specified in the `BaseTemplate`.
    /// - Returns: A SwiftUI view representing the fully styled content card
    func getCardUI() -> some View {
        self.view
            .background(backgroundColor)
    }
}
