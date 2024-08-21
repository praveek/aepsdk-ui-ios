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
import AEPSwiftUI
import AEPMessaging

struct HomePage: View {
    
    @State var savedCards : [ContentCardUI] = []
    
    var body: some View {
        Text("Content Cards").font(.title)
        ScrollView {
            VStack {
                 ForEach(savedCards) { card in
                     card.view
                         .frame(height: 150)
                         .overlay(
                             RoundedRectangle(cornerRadius: 5)
                                 .stroke(.gray, lineWidth: 1)
                         )
                         
                     
                }
            }
        }
        .padding()
        .onAppear(perform: {
            let homePageSurface = Surface(path: "homepage")
            AEPSwiftUI.getContentCardsUI(for: homePageSurface, { result in
                switch result {
                case .success(let cards):
                    
                    // customize each card only if
                    cards.forEach { card in
                        
                        // customize small image template card only
                        guard let template = card.template as? SmallImageTemplate else {
                            return
                        }
                        template.rootHStack.spacing = 10
                        template.textVStack.spacing = 10
                        template.title.textColor = .primary
                        template.body?.textColor = .secondary
                        template.body?.font = .subheadline
                    }
                    savedCards = cards
                    
                case .failure(let error):
                    print(error)
                    
                }
            })
        
        })
    }
}

#Preview {
    HomePage()
}
