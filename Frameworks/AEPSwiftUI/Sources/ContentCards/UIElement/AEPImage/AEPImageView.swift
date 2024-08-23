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

/// A view that displays an image based on the provided `AEPImage` model.
/// The view supports images sourced from either a URL or a bundled resource.
/// Additionally, the view adapts to light and dark modes, displaying the appropriate image based on the current interface style.
struct AEPImageView: View {
    /// The model containing the data about the image.
    @ObservedObject public var model: AEPImage

    /// The environment’s color scheme (light or dark mode).
    @Environment(\.colorScheme) var colorScheme

    /// Initializes a new instance of `AEPImageView` with the provided model
    /// - Parameter model: The `AEPImage` model containing information about the image to display.
    public init(model: AEPImage) {
        self.model = model
    }

    /// The body of the view
    public var body: some View {
        Group {
            switch model.imageSourceType {
            case .url:
                AsyncImage(url: themeBasedURL()) { image in
                    image.resizable()
                        .aspectRatio(contentMode: model.contentMode)
                } placeholder: {
                    ProgressView()
                }

            case .bundle:
                Image(themeBasedBundledImage())
                    .resizable()
                    .aspectRatio(contentMode: model.contentMode)
            }
        }.applyModifier(model.modifier)
    }

    /// Determines the appropriate URL for the image based on the device's color scheme.
    /// - Returns: The URL to be used for the image.
    private func themeBasedURL() -> URL {
        if colorScheme == .dark {
            return model.darkUrl ?? model.url!
        } else {
            return model.url!
        }
    }

    /// Determines the appropriate bundle resource for the image based on the color scheme of the device.
    /// - Returns: The name of the bundle resource to be used for the image.
    private func themeBasedBundledImage() -> String {
        if colorScheme == .dark {
            return model.darkBundle ?? model.bundle!
        } else {
            return model.bundle!
        }
    }
}
