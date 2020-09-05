//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Main
import iOSUi

class SignUpComposerTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        
        sut.signUp?(makeSigUpViewModel())
        
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            addAccountSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpComposerTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy:AddAccountSpy){
        let addAccountSpy = AddAccountSpy()
        let sut = SignUpComposer.composeControllerWith(addAccount: MainDispatchQueueDecorator(addAccountSpy))
        
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        
        return (sut, addAccountSpy)
    }
}
