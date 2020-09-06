//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 27/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class LoginPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let authentication: Authentication
    private let loadingView: LoadingView
    
    public init(validation: Validation, alertView: AlertView, authentication: Authentication, loadingView : LoadingView) {
        self.validation = validation
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
    }
    
    public func login(viewModel: LoginRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                
                switch result {
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Login efetuado com sucesso."))
                    
                case .failure(let error) :
                   var errorMessage: String!
                   
                   switch error {
                   case .expiredSession:
                       errorMessage = "Email e/ou senha inválido(s)."
                   default:
                       errorMessage = "Algo inesperado aconteceu. tente novamente em alguns instantes."
                   }
                   
                   self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
               }
            }
                        
        }
    }
    
}


