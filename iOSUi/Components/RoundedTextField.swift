//
//  RoundedTextField.swift
//  iOSUi
//
//  Created by Israel Ermel on 06/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit

public final class RoundedTextField: UITextField {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        layer.borderColor = Color.primaryLight.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
