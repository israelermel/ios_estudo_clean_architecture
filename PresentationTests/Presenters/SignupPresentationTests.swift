//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Israel Ermel on 27/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Presentation
import Domain

class SignupPresentationTests: XCTestCase {
    
    func test_signUp_should_show_erro_message_if_name_not_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "nome"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_email_not_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "e-mail"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_password_not_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "senha"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_passwordConfirmation_not_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "confirmação de senha"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_passwordConfirmation_not_match() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "confirma senha"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() throws {
        
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        
        let signUpViewModel = makeSigUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        
        emailValidatorSpy.simulateInvalidEmail()
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "e-mail"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_call_emailValidator_with_correct_values() throws {
        let addAccountSpy = AddAccountSpy()
        
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSigUpViewModel())
        
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails() throws {
        
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(message: "Algo inesperado aconteceu. tente novamente em alguns instantes."))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_loading_if_before_call_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let sut = makeSut(loadingView: loadingViewSpy)
        sut.signUp(viewModel: makeSigUpViewModel())
        XCTAssertEqual(loadingViewSpy.viewModel, LoadingViewModel(isLoading: true))
    }
    
    
    func test_number_format() {
        
    }
    
}

extension SignupPresentationTests {
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                 emailValidator: EmailValidatorSpy = EmailValidatorSpy(),
                 addAccount : AddAccountSpy = AddAccountSpy(),
                 loadingView: LoadingViewSpy = LoadingViewSpy(),
                 file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        
        let sut = SignUpPresenter(alertView: alertView,
                                  emailValidator: emailValidator,
                                  addAccount: addAccount,
                                  loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func makeSigUpViewModel(name: String? = "any_name",
                            email: String? = "any_email@email.com",
                            password: String? = "any_password",
                            passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        
        return SignUpViewModel(
            name: name, email: email, password: password, passwordConfirmation: passwordConfirmation
        )
    }
    
    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(
            title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
    }
    
    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(
            title: "Erro", message: message)
    }
    
    func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(
            title: "Falha na validação", message: "O campo \(fieldName) é inválido")
    }
    
    class AlertViewSpy: AlertView {
        
        var emit : ((AlertViewModel) -> Void)?
        
        func observe(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
        }
    }
    
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func simulateInvalidEmail() {
            isValid = false
        }
    }
    
    class AddAccountSpy: AddAccount {
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
    }
    
    class LoadingViewSpy: LoadingView {
        var viewModel: LoadingViewModel?
        
        func display(viewModel: LoadingViewModel) {
            self.viewModel = viewModel
        }
    }
}
