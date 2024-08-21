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

import AEPMessaging
import Foundation
import AEPServices

@objc(AEPSwiftUI)
@objcMembers
public class AEPSwiftUI: NSObject {
    public static var extensionVersion: String = Constants.EXTENSION_VERSION

    /// Retrieves the content cards UI for a given surface.
    /// - Parameters:
    ///   - surface: The surface for which to retrieve the content cards.
    ///   - completion: A closure that is called with the retrieved content cards or an error.
    public static func getContentCardsUI(for surface: Surface,
                                         _ completion: @escaping (Result<[ContentCardUI], Error>) -> Void) {
        // Request propositions for the specified surface from Messaging extension.
        Messaging.getPropositionsForSurfaces([surface]) { propositionDict, error in
            
            if let error = error {
                Log.error(label: Constants.LOG_TAG,
                            "Error retrieving content cards UI for surface, \(surface.uri). Error \(error)")
                completion(.failure(error))
                return
            }

            var cards: [ContentCardUI] = []
            
            // unwrap the proposition items for the given surface. Bail out with error if unsuccessful
            guard let propositions = propositionDict?[surface] else {
                completion(.failure(ContentCardUIError.dataUnavailable))
                return
            }

            for eachProposition in propositions {
                // attempt to retrieve the schema data from the proposition item.
                guard let schemaData = eachProposition.items.first?.contentCardSchemaData else {
                    Log.warning(label: Constants.LOG_TAG,
                                "Failed to retrieve contentCardSchemaData for proposition with ID \(eachProposition.uniqueId). Unable to create ContentCardUI.")
                    continue
                }
                
                // attempt to create a ContentCardUI instance with the schema data.
                guard let contentCard = ContentCardUI.createInstance(with: schemaData) else {
                    Log.warning(label: Constants.LOG_TAG,
                                "Failed to create ContentCardUI for schemaData : \(schemaData)")
                    continue
                }
                
                // append the successfully created content card to the cards array.
                cards.append(contentCard)
            }

            completion(.success(cards))
        }
    }
}
