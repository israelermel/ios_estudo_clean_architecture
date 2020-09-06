//
//  SignUpViewController.swift
//  iOSUi
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit

public class WelcomeViewController : UIViewController, Storyboarded {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    public var login: (() -> Void)?
    public var signUp: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        loginButton.layer.cornerRadius = 5
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        signUpButton.layer.cornerRadius = 5
        signUpButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
        
    @objc private func loginButtonTapped() {
        login?()
    }
    
    @objc private func signUpButtonTapped() {
        signUp?()
    }
}


