//
//  AddAccountUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 15/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol AddAccount {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func add(addAccountModel: AddAccountModel, completion: @escaping(Result) -> Void)
}
