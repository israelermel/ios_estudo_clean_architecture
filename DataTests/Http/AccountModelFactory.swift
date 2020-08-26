//
//  AccountModelFactory.swift
//  Data
//
//  Created by Israel Ermel on 17/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
   return AccountModel(id: "any_name", name: "any_name", email: "any_email", password: "any_password")
}
