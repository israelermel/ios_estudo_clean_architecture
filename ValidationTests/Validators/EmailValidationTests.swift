//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Presentation
import Validation

class EmailValidationTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() {
        let emailValidatorSpy = EmailValidatorSpy()
        
        let sut = makeSut(fieldName: "email", fieldLabel: "Email12", emailValidator: emailValidatorSpy)
        
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        
        XCTAssertEqual(errorMessage, "O campo Email12 é inválido")
    }
    
    func test_validate_should_return_error_if_valid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        
        let errorMessage = sut.validate(data: ["email": "valid_email@gmail.com"])
        
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_data_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy())
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }
    
}

extension EmailValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorSpy, file: StaticString = #file, line: UInt = #line) -> Validation {
        
        let sut =  EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        
        checkMemoryLeak(for: sut, file: file, line: line)
        
        return sut
    }
}
