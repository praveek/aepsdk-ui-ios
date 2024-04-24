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

// A UIView that displays a title and a body
class TitleBodyView: UIView {
    // Color constants
    enum DefaultColor {
        static let TITLE = UIColor.black
        static let DESCRIPTION = UIColor.darkGray
    }

    // Constants
    let TITLE_HEIGHT = 25.0
    let PADDING_BETWEEN_VIEWS = 5.0

    // UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "AEPNotificationContentTitle"
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "AEPNotificationContentDescription"
        return label
    }()

    private var bodyHeightConstraint: NSLayoutConstraint!

    // MARK: - Computed Properties

    var viewHeight: CGFloat {
        TITLE_HEIGHT + bodyHeightConstraint.constant + PADDING_BETWEEN_VIEWS
    }

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setupWith(payload: TitleBodyPayload, viewWidth: CGFloat) {
        setupView()
        configure(withPayload: payload, viewWidth: viewWidth)
    }

    func change(payload: TitleBodyPayload, viewWidth: CGFloat) {
        configure(withPayload: payload, viewWidth: viewWidth)
    }

    // MARK: - Private methods

    /// Sets up the view
    private func setupView() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setupConstraints()
    }

    /// Sets up the constraints for the view
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: TITLE_HEIGHT),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: PADDING_BETWEEN_VIEWS),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        /// Set the dynamic height constraint for the description label
        bodyHeightConstraint = descriptionLabel.heightAnchor.constraint(equalToConstant: 0)
        bodyHeightConstraint.priority = .defaultHigh
        bodyHeightConstraint.isActive = true
    }

    // MARK: - Configuration

    func configure(withPayload payload: TitleBodyPayload, viewWidth: CGFloat) {
        titleLabel.text = payload.title
        titleLabel.textColor = DefaultColor.TITLE
        descriptionLabel.text = payload.body
        descriptionLabel.textColor = DefaultColor.DESCRIPTION
        updateBodyHeight(with: payload.body, viewWidth: viewWidth)
    }

    func changeColor(from payload: Payload) {
        titleLabel.textColor = payload.titleColor
        descriptionLabel.textColor = payload.descriptionColor
    }

    private func updateBodyHeight(with text: String?, viewWidth: CGFloat) {
        // If no valid text is provided, set the height to zero
        guard let text = text, !text.isEmpty else {
            bodyHeightConstraint.constant = 0.0
            return
        }

        // Calculate the height required to fit the text within the given width
        let requiredHeight = text.height(withConstrainedWidth: viewWidth, font: descriptionLabel.font)

        // Update the body height constraint with the calculated height
        bodyHeightConstraint.constant = requiredHeight
    }
}
