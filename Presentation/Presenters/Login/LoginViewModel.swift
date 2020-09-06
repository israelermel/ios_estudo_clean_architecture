//
//  SignUpViewModel.swift
//  PresentationTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct LoginViewModel: Model {
    public var email: String?
    public var password: String?
    
    public init(email: String? = nil, password: String? = nil) {
        self.email = email
        self.password = password
    }
    
    func toAuthenticationModel() -> AuthenticationModel {
       return AuthenticationModel(email: self.email!, password: self.password!)

   }
}
