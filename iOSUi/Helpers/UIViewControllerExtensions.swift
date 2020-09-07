//
//  UIViewControllerExtensions.swift
//  iOSUi
//
//  Created by Israel Ermel on 03/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
}
