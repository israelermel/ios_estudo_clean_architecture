//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    var emit : ((LoadingViewModel) -> Void)?
    
    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
