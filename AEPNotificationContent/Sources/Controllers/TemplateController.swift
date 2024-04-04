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

class TemplateController : UIViewController {
        
    let SIDE_MARGIN = 8.0
    let TOP_MARGIN = 10.0
    
    // MARK: - UI Elements
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            loadingIndicator.style = .medium
        } else {
            loadingIndicator.style = .white
        }
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.center = self.view.center
        return loadingIndicator
    }()
 
    let delegate: TemplateControllerDelegate
    
    
    // MARK: - Initializers
    init(delegate: TemplateControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("BaseTemplateController cannot be initialized from storyboard.")
    }
    
    
    // MARK: - Loading Indicator methods
    
    func showLoadingIndicator() {
        self.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }

    func removeLoadingIndicator() {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.removeFromSuperview()
    }
}

