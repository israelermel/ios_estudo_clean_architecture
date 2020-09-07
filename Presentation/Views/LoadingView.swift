//
//  LoadingView.swift
//  Presentation
//
//  Created by Israel Ermel on 28/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
 
public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
