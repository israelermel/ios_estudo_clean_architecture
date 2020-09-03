//
//  SignUpTests.swift
//  iOSUiTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import UIKit
@testable import iOSUi

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }

}
