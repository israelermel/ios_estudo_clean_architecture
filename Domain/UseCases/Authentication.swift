//
//  Authentication.swift
//  Domain
//
//  Created by Israel Ermel on 06/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Result) -> Void)
}

public struct AuthenticationModel: Model {
    public var email: String
    public var password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
