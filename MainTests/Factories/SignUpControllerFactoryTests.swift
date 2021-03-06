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
import Validation

class SignUpControllerFactoryTests: XCTestCase {

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
    
    func test_signUp_compose_with_correct_validations() {
        let validations = makeSignUpValidations()
        
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"))
        
        XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        
        XCTAssertEqual(validations[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"))
        
        XCTAssertEqual(validations[4] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "passwordConfirmation", fieldNameToCompare: "password", fieldLabel: "Confirmar Senha"))
                
    }
}

extension SignUpControllerFactoryTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy:AddAccountSpy){
        let addAccountSpy = AddAccountSpy()
        let sut = makeSignUpControllerWith(addAccount: MainDispatchQueueDecorator(addAccountSpy))
        
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        
        return (sut, addAccountSpy)
    }
}
