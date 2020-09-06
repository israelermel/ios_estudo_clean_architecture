//
//  EmailValidator.swift
//  Presentation
//
//  Created by Israel Ermel on 27/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
