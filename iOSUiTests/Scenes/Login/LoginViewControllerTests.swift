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

class LoginViewControllerTests: XCTestCase {
    
    func test_loading_is_hidden_on_start() throws {
        let sut = makeSut()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
    
    func tests_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_loginButton_calls_login_on_tap() {
        var loginViewModel: LoginRequest?
        let sut = makeSut(loginSpy: { loginViewModel = $0 })
                
        sut.loginButton?.simulateTap()
                
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        
        XCTAssertEqual(loginViewModel, LoginRequest(email: email, password: password))
    }
}


extension LoginViewControllerTests {
    func makeSut(loginSpy: ((LoginRequest) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController.instantiate()
        sut.loadViewIfNeeded()
        sut.login = loginSpy
        
        checkMemoryLeak(for: sut)
        
        return sut
    }
}


