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

public class AEPHStack: ObservableObject {
    @Published var views: [AnyView] = []
    @Published public var spacing: CGFloat?
    @Published public var alignment: VerticalAlignment?
    
    public lazy var view: some View = AEPHStackView(model: self)
    
    func addView<V: View>(_ view: V) {
        views.append(AnyView(view))
    }
    
    func removeView(at index: Int) {
        guard views.indices.contains(index) else { return }
        views.remove(at: index)
    }
}
