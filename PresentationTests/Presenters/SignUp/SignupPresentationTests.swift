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
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu. tente novamente em alguns instantes."))
            
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
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Conta criada com sucesso."))
            
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
    
    func test_signUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        
        let viewModel = makeSigUpViewModel()
        sut.signUp(viewModel: viewModel)
        
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
        sut.signUp(viewModel: makeSigUpViewModel())
        wait(for: [exp], timeout: 1)
    }
    
}

extension SignupPresentationTests {
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                 addAccount : AddAccountSpy = AddAccountSpy(),
                 loadingView: LoadingViewSpy = LoadingViewSpy(),
                 validation: ValidationSpy = ValidationSpy(),
                 file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        
        let sut = SignUpPresenter(alertView: alertView,
                                  addAccount: addAccount,
                                  loadingView: loadingView,
                                  validation: validation)
        
        checkMemoryLeak(for: sut, file: file, line: line)
        
        return sut
    }
}
