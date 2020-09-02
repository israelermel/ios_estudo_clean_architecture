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
                        passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    
    return SignUpViewModel(
        name: name, email: email, password: password, passwordConfirmation: passwordConfirmation
    )
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(
        title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(
        title: "Erro", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(
        title: "Sucesso", message: message)
}


func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(
        title: "Falha na validação", message: "O campo \(fieldName) é inválido")
}
