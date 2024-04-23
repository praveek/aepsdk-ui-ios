//
// Copyright 2024 Adobe. All rights reserved.
// This file is licensed to you under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License. You may obtain a copy
// of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
// OF ANY KIND, either express or implied. See the License for the specific language
// governing permissions and limitations under the License.
//

import SwiftUI

struct ContentView: View {
    
    @State private var txtFieldInput: String = ""
    var body: some View {
        VStack {
            
            Spacer()
            
            // Text field for user input
            TextField("Enter userInfo JSONString", text: $txtFieldInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Trigger Notification", action: {
                triggerNotification()
            })
            
            Spacer()
        }
        .padding()
        
    }
    
    private func triggerNotification() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.body = "Notification Body"
        content.sound = .default
        content.categoryIdentifier = "AEPNotification"

        // Parse user input into a dictionary
        let userData = parseUserInfo(from: txtFieldInput)
        content.userInfo = userData
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
        
        center.add(request)
    }
    
    private func parseUserInfo(from input: String) -> [AnyHashable: Any] {
        let data = Data(input.utf8)
        if let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return dictionary
        }
        return [:]
    }
}

#Preview {
    ContentView()
}
