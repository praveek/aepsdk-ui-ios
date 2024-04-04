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

// ViewController for Carousel Template
class CarouselTemplateController: TemplateController, UIScrollViewDelegate {
    // MARK: - Dimension Constants
    let ARROW_SIZE = 40.0
    let PAGE_CONTROL_HEIGHT = 20.0

    private let payload: CarouselPayload

    private var currentPageIndex: Int = 0
    private var autoScrollTimer: Timer?

    // dynamic dimensions
    var TITLE_DESCRIPTION_WIDTH: CGFloat {
        view.frame.width - (2 * SIDE_MARGIN)
    }

    var SCROLL_VIEW_HEIGHT: CGFloat {
        view.frame.width / 2
    }

    // MARK: - UI Elements

    lazy var titleBodyView: UITitleBody = {
        let view = UITitleBody()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var leftArrowButton: UIButton = {
        let button = UIButton(type: .system)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.tintColor = .gray
        button.layer.cornerRadius = ARROW_SIZE / 2
        button.addTarget(self, action: #selector(leftArrowClicked), for: .touchUpInside)
        return button
    }()

    lazy var rightArrowButton: UIButton = {
        let button = UIButton(type: .system)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.tintColor = .gray
        button.layer.cornerRadius = ARROW_SIZE / 2
        button.addTarget(self, action: #selector(rightArrowClicked), for: .touchUpInside)
        return button
    }()

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - Initialization

    init(withPayload payload: CarouselPayload, delegate: TemplateControllerDelegate) {
        self.payload = payload
        super.init(delegate: delegate)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("Carousel Template Controller cannot be initialized with Storyboard")
    }

    override func viewDidLoad() {
        // quick bail out of the carouselItems list is empty
        if payload.carouselItems.isEmpty {
            delegate.templateFailedToLoad()
            return
        }

        showLoadingIndicator()
        let imageURLs = payload.carouselItems.map { $0.imageURL.absoluteString }
        ImageDownloader().downloadImages(urls: imageURLs, completion: { [self] result in
            switch result {
            case let .success(downloads):
                removeLoadingIndicator()
                // add images to the carousel items
                payload.carouselItems.forEach { $0.image = downloads[$0.imageURL.absoluteString] }
                setupView()
            case let .failure(error):
                print(error)
                delegate.templateFailedToLoad()
            }
        })
    }

    // MARK: - UI Setup
    func setupView() {
        setupScrollView()
        setupPageControl()
        setupArrowButtons()
        setupTitleAndDescription()
        view.backgroundColor = payload.backgroundColor
        updatePreferredContentSize()
        setCarouselMode()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: CGFloat(SCROLL_VIEW_HEIGHT))
        ])

        // Add images to the scroll view
        for (index, item) in payload.carouselItems.enumerated() {
            let imageView = UIImageView(image: item.image)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: CGFloat(index) * view.frame.width, y: 0, width: view.frame.width, height: SCROLL_VIEW_HEIGHT)
            scrollView.addSubview(imageView)
        }

        // Set scroll view content size
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(payload.carouselItems.count), height: SCROLL_VIEW_HEIGHT)
    }

    private func setupPageControl() {
        // Setup for PageControl
        pageControl.numberOfPages = payload.carouselItems.count
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: CGFloat(PAGE_CONTROL_HEIGHT))
        ])
    }

    private func setupArrowButtons() {
        // Left Arrow Button
        leftArrowButton.frame = CGRect(x: 10, y: (SCROLL_VIEW_HEIGHT - ARROW_SIZE) / 2, width: ARROW_SIZE, height: ARROW_SIZE)
        view.addSubview(leftArrowButton)

        // Right Arrow Button
        rightArrowButton.frame = CGRect(x: (view.frame.width - ARROW_SIZE) - 10, y: (SCROLL_VIEW_HEIGHT - ARROW_SIZE) / 2, width: ARROW_SIZE, height: ARROW_SIZE)
        view.addSubview(rightArrowButton)
    }

    private func setupTitleAndDescription() {
        titleBodyView.setupWith(payload: payload.carouselItems.first!.titleBodyPayload, viewWidth: TITLE_DESCRIPTION_WIDTH)
        titleBodyView.changeColor(from: payload)
        view.addSubview(titleBodyView)
        NSLayoutConstraint.activate([
            titleBodyView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: TOP_MARGIN),
            titleBodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SIDE_MARGIN),
            titleBodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SIDE_MARGIN),
            titleBodyView.heightAnchor.constraint(equalToConstant: titleBodyView.viewHeight),
        ])
    }

    // MARK: - ScrollView Delegate Method

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
        pageControl.currentPage = pageIndex

        // Update titleBodyView only if the page index has changed
        if pageIndex != currentPageIndex {
            currentPageIndex = pageIndex
            changeTitleBody(forPageIndex: pageIndex)
        }
    }

    // MARK: - Interaction Handlers

    @objc func rightArrowClicked() {
        let currentPage = min(pageControl.currentPage + 1, payload.carouselItems.count - 1)
        let x = CGFloat(currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    @objc func leftArrowClicked() {
        let currentPage = max(pageControl.currentPage - 1, 0)
        let x = CGFloat(currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    @objc func pageControlChanged(_ sender: UIPageControl) {
        let x = CGFloat(sender.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    @objc func onCarouselTimerFired() {
        let nextPage = (pageControl.currentPage + 1) % payload.carouselItems.count
        let x = CGFloat(nextPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        pageControl.currentPage = nextPage
    }

    // MARK: - Other Methods

    private func updatePreferredContentSize() {
        preferredContentSize.height = titleBodyView.viewHeight + SCROLL_VIEW_HEIGHT + (2 * TOP_MARGIN)
        parent?.preferredContentSize.height = titleBodyView.viewHeight + SCROLL_VIEW_HEIGHT + (2 * TOP_MARGIN)
    }

    private func setCarouselMode() {
        if payload.carouselItems.count > 1 && payload.carouselMode == .auto {
            autoScrollTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(onCarouselTimerFired), userInfo: nil, repeats: true)
        }
    }

    private func changeTitleBody(forPageIndex index: Int) {
        if index >= 0 && index < payload.carouselItems.count {
            let titleBodyPayload = payload.carouselItems[index].titleBodyPayload
            titleBodyView.change(payload: titleBodyPayload, viewWidth: TITLE_DESCRIPTION_WIDTH)
            titleBodyView.changeColor(from: payload)
            updatePreferredContentSize()
        }
    }
}
