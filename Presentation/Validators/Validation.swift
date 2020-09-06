//
//  Validation.swift
//  Presentation
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
