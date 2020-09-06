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

class WelcomeViewControllerTests: XCTestCase {
    
    func test_loginButton_calls_login_on_tap() {
        let (sut, buttonSpy) = makeSut()
                
        sut.loginButton?.simulateTap()
            
        XCTAssertEqual(buttonSpy.clicks, 1)
    }
    
    func test_loginButton_calls_signUp_on_tap() {
        let (sut, buttonSpy) = makeSut()
                
        sut.signUpButton?.simulateTap()
            
        XCTAssertEqual(buttonSpy.clicks, 1)
    }
}


extension WelcomeViewControllerTests {
    func makeSut() -> (sut: WelcomeViewController, buttonSpy: ButtonSpy) {
        let buttonSpy = ButtonSpy()
        
        let sut = WelcomeViewController.instantiate()
        sut.login = buttonSpy.onClick
        sut.signUp = buttonSpy.onClick
        sut.loadViewIfNeeded()
        
        checkMemoryLeak(for: sut)
        
        return sut
    }
}

class ButtonSpy {
    var clicks = 0
    func onClick() {
        clicks += 1
    }
}
