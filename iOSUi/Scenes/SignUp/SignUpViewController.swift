//
//  SignUpViewController.swift
//  iOSUi
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit
import Presentation

public class SignUpViewController : UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationPasswordTextField: UITextField!
    
    public var signUp: ((SignUpRequest) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        saveButton.layer.cornerRadius = 5
        
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func saveButtonTapped() {
        let viewModel = SignUpRequest(name: nameTextField.text, email: mailTextField.text, password: passwordTextField.text, passwordConfirmation: confirmationPasswordTextField.text)
        
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator?.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
