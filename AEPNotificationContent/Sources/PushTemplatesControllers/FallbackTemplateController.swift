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

class FallbackTemplateController: UIViewController {
    private let SIDE_MARGIN = 8.0
    private let TOP_MARGIN = 8.0

    private let notification: UNNotification
    private var titleDescriptionHeight = 0.0

    // MARK: - Initialization

    /// Initializes the FallbackTemplate with the provided notification.
    /// - Parameter notification: The notification to be displayed.
    init(notification: UNNotification) {
        self.notification = notification
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("FallbackTemplate cannot be initialized from storyboard.")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - View Setup

    /// Sets up the view with the notification content.
    private func setupView() {
        let payload = TitleDescriptionPayload(title: notification.request.content.title,
                                              description: notification.request.content.body,
                                              titleColor: .black,
                                              descriptionColor: .darkGray)

        let titleDescriptionView = TitleDescriptionView(withPayload: payload, viewWidth: view.frame.width - (2 * SIDE_MARGIN))
        titleDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        titleDescriptionHeight = titleDescriptionView.viewHeight
        view.addSubview(titleDescriptionView)

        NSLayoutConstraint.activate([
            titleDescriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: TOP_MARGIN),
            titleDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SIDE_MARGIN),
            titleDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SIDE_MARGIN),
            titleDescriptionView.heightAnchor.constraint(equalToConstant: titleDescriptionHeight),
        ])

        updatePreferredContentSize()
    }

    private func updatePreferredContentSize() {
        preferredContentSize.height = titleDescriptionHeight + (2 * TOP_MARGIN)
    }
}
