//
//  SignUpComposer.swift
//  Main
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import iOSUi
import Presentation
import Validation


public func makeLoginController() -> LoginViewController {
    return makeLoginControllerWith(authentication: makeRemoteAuthentication())
}

public func makeLoginControllerWith(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    
    let presenter = LoginPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), authentication: authentication, loadingView: WeakVarProxy(controller))
    controller.login = presenter.login
    return controller
}


public func makeLoginValidations() -> [Validation] {
    return ValidationBuilder
            .field("email")
            .label("Email")
            .required()
            .validateEmail()
            .build() +
        ValidationBuilder
            .field("password")
            .label("Senha")
            .required()
            .build()
}
