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
        alertViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "nome"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_email_not_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "e-mail"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_password_not_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "senha"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_passwordConfirmation_not_provided() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "confirmação de senha"))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_erro_message_if_passwordConfirmation_not_match() throws {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "confirma senha"))
            
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
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "e-mail"))
            
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
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Algo inesperado aconteceu. tente novamente em alguns instantes."))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_success_message_if_addAccount_succeeds() throws {
        
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Conta criada com sucesso."))
            
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
        
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_loading_before_call_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSigUpViewModel())
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
           XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
           exp2.fulfill()
        }
        
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
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
}
