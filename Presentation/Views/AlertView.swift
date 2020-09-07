//
//  AlertView.swift
//  Presentation
//
//  Created by Israel Ermel on 27/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel : Equatable{
    public var title: String
    public var message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}



