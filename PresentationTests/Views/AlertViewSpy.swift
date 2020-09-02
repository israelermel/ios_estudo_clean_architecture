//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Presentation

class AlertViewSpy: AlertView {
    
    var emit : ((AlertViewModel) -> Void)?
    
    func observe(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }
    
    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}
