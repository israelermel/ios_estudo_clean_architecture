
//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Israel Ermel on 06/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
    
    func test_auth_should_call_httpClient_with_correct_url() {
        // given
        let url = makeUrl()
        
        // when
        let (sut, httpClientSpy) = makeSut(url: url)
        
        // then
        let authenticationModel = makeAuthenticationModel()
        sut.auth(authenticationModel: authenticationModel){ _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_auth_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.auth(authenticationModel: authenticationModel){ _ in }
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWith(error: .noConnectivity)
        })
    }
    
    func test_auth_should_complete_with_expired_session_error_if_client_completes_with_authorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.expiredSession), when: {
            httpClientSpy.completeWith(error: .unauthorized)
        })
    }
    
    func test_auth_should_complete_with_account_if_client_complestes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account), when: {
            httpClientSpy.completeWith(data: account.toData()!)
        })
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWith(data: makeInvalidData())
        })
    }
    
    func test_add_should_not_complete_if_has_been_desallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAuthentication? = RemoteAuthentication(url: makeUrl(), httpClient: httpClientSpy)
        var result: Authentication.Result?
        
        sut?.auth(authenticationModel: makeAuthenticationModel(), completion: { result = $0 })
        sut = nil
        httpClientSpy.completeWith(error: .noConnectivity)
        
        XCTAssertNil(result)
    }
}

extension RemoteAuthenticationTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
        
        let httpPostClient = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpPostClient)
        
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpPostClient, file: file, line: line)
        
        return (sut, httpPostClient)
    }
    
    func expect(_ sut: RemoteAuthentication, completeWith expectedResult: Authentication.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(authenticationModel: makeAuthenticationModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}

