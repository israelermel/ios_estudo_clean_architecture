//
//  SignUpTests.swift
//  iOSUiTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import UIKit
import Presentation
@testable import iOSUi

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        let sut = makeSut()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }

    func test_sut_implements_loadingView() {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_saveButton_calls_signUp_on_tap() {
        var signUpViewModel: SignUpViewModel?
        
        let signUpSpy : (SignUpViewModel) -> Void = { signUpViewModel = $0}
        
        let sut = makeSut(signUpSpy: signUpSpy)
        
        sut.saveButton?.simulateTap()
        
        let name = sut.nameTextField?.text
        let mail = sut.mailTextField?.text
        let password = sut.passwordTextField?.text
        let confirmationPassword = sut.confirmationPasswordTextField?.text
        
        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name, email: mail, password: password, passwordConfirmation: confirmationPassword))
    }
}


extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) ->SignUpViewController {
        let sut = SignUpViewController.instantiate()
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}


