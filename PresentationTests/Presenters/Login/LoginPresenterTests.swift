//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Israel Ermel on 06/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Presentation
import Domain

class LoginPresenterTests: XCTestCase {
    
    func test_login_should_call_emailValidator_with_correct_values() throws {
        let validationSpy = ValidationSpy()
        
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()
        
        sut.login(viewModel: viewModel)
        
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_signUp_should_show_erro_message_if_validation_fails() throws {
        let validationSpy = ValidationSpy()
        let alertViewSpy = AlertViewSpy()
        
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            
            exp.fulfill()
        }
        
        validationSpy.simulateError()
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_auth_should_call_authentication_with_correct_values() throws {
        let authenticationSpy = AuthenticationSpy()
        
        let sut = makeSut(authentication: authenticationSpy)
        sut.login(viewModel: makeLoginViewModel())
        
        XCTAssertEqual(authenticationSpy.authenticationModel, makeAuthenticationModel())
    }
    
    func test_login_should_show_generic_error_message_if_authentication_fails() {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu. tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_expired_session_error_message_if_authentication_completes_with_expired_session() {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Email e/ou senha inválido(s)."))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithError(.expiredSession)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_success_message_if_addAccount_succeeds() throws {
        
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Login efetuado com sucesso."))
            
            exp.fulfill()
        }
        
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithAccount(makeAccountModel())
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_loading_before_and_after_call_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let authenticationSpy = AuthenticationSpy()
        
        let sut = makeSut(authentication: authenticationSpy, loadingView: loadingViewSpy)
        
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
           XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
           exp2.fulfill()
        }
        
        authenticationSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    
}

extension LoginPresenterTests {
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), authentication: AuthenticationSpy = AuthenticationSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(),
                 file: StaticString = #file, line: UInt = #line) -> LoginPresenter {
        
        let sut = LoginPresenter(validation: validation, alertView: alertView, authentication: authentication, loadingView: loadingView)
        
        checkMemoryLeak(for: sut, file: file, line: line)
        
        return sut
    }
}
