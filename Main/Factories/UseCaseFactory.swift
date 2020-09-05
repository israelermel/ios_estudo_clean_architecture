//
//  UseCaseFactory.swift
//  Main
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = "https://clean-node-api.herokuapp.com/api"
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        return RemoteAddAccount(url: makeUrl(path: "signUp"), httpClient: httpClient)
    }
}
