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

public func makeSignUpController(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    
    let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller), validation: validationComposite)
    
    controller.signUp = presenter.signUp
    return controller
}


public func makeSignUpValidations() -> [Validation] {
    return [RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
            CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")]
}
