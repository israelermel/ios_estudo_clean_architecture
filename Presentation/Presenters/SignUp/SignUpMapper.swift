//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain


public final class SignUpMapper {

    static func toAddAccountModel(viewModel: SignUpViewModel) -> AddAccountModel {
        return AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)

    }
}
