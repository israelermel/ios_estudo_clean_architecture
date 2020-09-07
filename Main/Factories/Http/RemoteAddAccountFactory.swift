//
//  UseCaseFactory.swift
//  Main
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemoteAddAccount() -> AddAccount {
   return makeRemoteAddAccountWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAddAccountWith(httpClient: HttpPostClient) -> AddAccount {
   let remoteAddAccount = RemoteAddAccount(url: makeApiUrl(path: "signUp"), httpClient: httpClient)
   return MainDispatchQueueDecorator(remoteAddAccount)
}


