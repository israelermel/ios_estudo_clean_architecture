//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Israel Ermel on 03/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }

    func test_valid_emails() throws {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "teste@gmail.com"))
    }

}
 
extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
