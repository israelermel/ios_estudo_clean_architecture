//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Presentation

func makeSigUpViewModel(name: String? = "any_name",
                        email: String? = "any_email@email.com",
                        password: String? = "any_password",
                        passwordConfirmation: String? = "any_password") -> SignUpRequest {
    
    return SignUpRequest(
        name: name, email: email, password: password, passwordConfirmation: passwordConfirmation
    )
}

func makeLoginViewModel(email: String? = "any_email@email.com", password: String? = "any_password") -> LoginRequest {
    return LoginRequest(email: email, password: password)
}
