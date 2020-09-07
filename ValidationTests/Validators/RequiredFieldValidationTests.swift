//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["name": "israel"])
        XCTAssertEqual(errorMessage, "O campo Email é obrigatório")
    }
    
    func test_validate_should_return_error_with_correct_fieldName() {
        let sut = makeSut(fieldName: "age", fieldLabel: "Idade")
        let errorMessage = sut.validate(data: ["name": "israel"])
        XCTAssertEqual(errorMessage, "O campo Idade é obrigatório")
    }
    
    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "israel@teste.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = RequiredFieldValidation(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é obrigatório")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #file, line: UInt = #line) -> Validation {
        
        let sut =  RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
