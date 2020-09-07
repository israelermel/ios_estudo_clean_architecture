//
//  AccountModel.swift
//  Domain
//
//  Created by Israel Ermel on 15/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public struct AccountModel: Model {
    public var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
