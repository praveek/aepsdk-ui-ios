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

class TitleDescriptionView: UIView {
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
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var descriptionHeightConstraint: NSLayoutConstraint!

    // MARK: - Computed Properties

    var viewHeight: CGFloat {
        TITLE_HEIGHT + descriptionHeightConstraint.constant + PADDING_BETWEEN_VIEWS
    }

    // MARK: - Initialization

    init(withPayload payload: TitleDescriptionPayload, viewWidth: CGFloat) {
        super.init(frame: .zero)
        setupView()
        configure(withPayload: payload, viewWidth: viewWidth)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setupConstraints()
    }

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

        descriptionHeightConstraint = descriptionLabel.heightAnchor.constraint(equalToConstant: 0)
        descriptionHeightConstraint.priority = .defaultHigh
        descriptionHeightConstraint.isActive = true
    }

    // MARK: - Configuration

    func configure(withPayload payload : TitleDescriptionPayload, viewWidth: CGFloat) {
        titleLabel.text = payload.title
        descriptionLabel.text = payload.description
        titleLabel.textColor = payload.titleColor
        descriptionLabel.textColor = payload.descriptionColor
        updateDescriptionHeight(with: payload.description, viewWidth: viewWidth)
    }

    private func updateDescriptionHeight(with text: String, viewWidth: CGFloat) {
        let height = text.height(withConstrainedWidth: viewWidth, font: descriptionLabel.font)
        descriptionHeightConstraint.constant = height
    }
}
