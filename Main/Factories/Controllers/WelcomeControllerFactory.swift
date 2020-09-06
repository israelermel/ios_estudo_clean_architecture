//
//  SignUpComposer.swift
//  Main
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import iOSUi


public func makeWelcomeController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginController, signUpFactory: makeSignUpController)
    let controller = WelcomeViewController.instantiate()
    controller.signUp = router.gotoSignUp
    controller.login = router.gotoLogin
    
    return controller
}

