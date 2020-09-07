//
//  UseCasesIntegrationsTests.swift
//  UseCasesIntegrationsTests
//
//  Created by Israel Ermel on 26/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain


class UseCasesIntegrationsTests: XCTestCase {
    
    func test_add_account() throws {
        
        let alamofireAdapter = AlamofireAdapter()
        
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        
        let addAccountModel = AddAccountModel(name: "israel", email: "\(UUID().uuidString)@gmail.com", password: "secret", passwordConfirmation: "secret")
        
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        let exp2 = expectation(description: "waiting")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure(let error) where error == .emailInUse:
                XCTAssertNotNil(error)
            default:
                XCTFail("Expect success got \(result) instead")
            }
            exp2.fulfill()
        }
        
        wait(for: [exp2], timeout: 5)
    }
    
    func test_add_account_failure() throws {
        
        let alamofireAdapter = AlamofireAdapter()
        
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        
        let addAccountModel = AddAccountModel(name: "israel", email: "israel@gmail.com", password: "secret", passwordConfirmation: "secret2")
        
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            case .success: XCTFail("Expect success got \(result) instead")
                
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    
}
