
//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

class AuthenticationSpy: Authentication {
    var authenticationModel: AuthenticationModel?
    var completion: ((Authentication.Result) -> Void)?

    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
        self.completion = completion
    }

    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }

    func completeWithAccount(_ account: AccountModel) {
        completion?(.success(account))
    }
}

