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

import AEPServices
import Foundation
import SwiftUI

public class AEPStack: ObservableObject {
    /// An array of child view models of the  stack, each conforming to `AEPViewModel`.
    @Published var childModels: [any AEPViewModel] = []

    /// The spacing between child views in the  stack.
    @Published public var spacing: CGFloat?

    /// Adds a view model to the stack.
    /// This method is used internally to
    /// - Parameter model: The view model to be added, conforming to `AEPViewModel`.
    func addModel<M: AEPViewModel>(_ model: M) {
        childModels.append(model)
    }

    /// Adds a view as the last child of the stack.
    /// - Parameter view: The SwiftUI view to be added.
    public func addView<V: View>(_ view: V) {
        let model = AnyViewModel(wrappedView: view)
        childModels.append(model)
    }

    /// Inserts a view at the specified index in the horizontal stack.
    ///
    /// - Parameters:
    ///   - view: The SwiftUI view to be inserted
    ///   - index: The index at which to insert the view model.
    public func insertView<V: View>(_ view: V, at index: Int) {
        guard index >= 0 && index <= childModels.count else {
            Log.warning(label: Constants.LOG_TAG, "AEPStack: Cannot insert view at index \(index). Index out of bounds.")
            return
        }
        let model = AnyViewModel(wrappedView: view)
        childModels.insert(model, at: index)
    }

    /// Removes a model and its view from the stack at the specified index.
    /// - Parameter index: The index of the view model to be removed.
    public func removeView(at index: Int) {
        guard childModels.indices.contains(index) else {
            Log.warning(label: Constants.LOG_TAG, "AEPStack: Cannot remove view at index \(index). Index out of bounds.")
            return
        }
        childModels.remove(at: index)
    }
}
