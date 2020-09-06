//
//  DataTests.swift
//  DataTests
//
//  Created by Israel Ermel on 15/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url() {
        // given
        let url = makeUrl()
        
        // when
        let (sut, httpClientSpy) = makeSut(url: url)
        
        // then
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_addAccountModel() {
        // given
        let addAcccountModel = makeAddAccountModel()
        
        // when
        let (sut, httpClientSpy) = makeSut()
        
        // then
        sut.add(addAccountModel: addAcccountModel) { _ in }
        
        XCTAssertEqual(httpClientSpy.data, addAcccountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_error() {
        // given
        let addAcccountModel = makeAddAccountModel()
        let exp = expectation(description: "waiting")
        
        // when
        let (sut, httpClientSpy) = makeSut()
        
        // then
        sut.add(addAccountModel: addAcccountModel){ result in
            switch result {
            case .failure(let error) : XCTAssertEqual(error, .unexpected)
            case .success : XCTFail("Expected error reveived \(result) instead")
            }
            exp.fulfill()
        }
        
        httpClientSpy.completeWith(error: .noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_forbidden() {
           // given
           let addAcccountModel = makeAddAccountModel()
           let exp = expectation(description: "waiting")
           
           // when
           let (sut, httpClientSpy) = makeSut()
           
           // then
           sut.add(addAccountModel: addAcccountModel){ result in
               switch result {
               case .failure(let error) : XCTAssertEqual(error, .emailInUse)
               case .success : XCTFail("Expected error reveived \(result) instead")
               }
               exp.fulfill()
           }
           
           httpClientSpy.completeWith(error: .forbidden)
           wait(for: [exp], timeout: 1)
       }
    
    func test_add_should_complete_with_error_if_client_completes_with_valid_data() {
        // given
        let addAcccountModel = makeAddAccountModel()
        let exp = expectation(description: "waiting")
        let expectedAccount = makeAccountModel()
        
        // when
        let (sut, httpClientSpy) = makeSut()
        
        // then
        sut.add(addAccountModel: addAcccountModel){ result in
            switch result {
            case .failure: XCTFail("Expected success reveived \(result) instead")
            case .success(let receivedAccount): XCTAssertEqual(receivedAccount, expectedAccount)
            }
            exp.fulfill()
        }
        
        httpClientSpy.completeWith(data: expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() {
        // given
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeUrl(), httpClient: httpClientSpy)
        var result: AddAccount.Result?
        
        // when
        sut?.add(addAccountModel: makeAddAccountModel()) {result = $0}
        
        sut = nil
        httpClientSpy.completeWith(error: .noConnectivity)
        
        // then
        XCTAssertNil(result)
    }
    
    func test_add_should_not_complete_if_has_been_desallocated() {
        // given
        let addAcccountModel = makeAddAccountModel()
        let exp = expectation(description: "waiting")
        
        // when
        let (sut, httpClientSpy) = makeSut()
        
        // then
        sut.add(addAccountModel: addAcccountModel){ result in
            switch result {
            case .failure(let error) : XCTAssertEqual(error, .unexpected)
            case .success : XCTFail("Expected error reveived \(result) instead")
            }
            exp.fulfill()
        }
        
        httpClientSpy.completeWith(data: makeInvalidData())
        wait(for: [exp], timeout: 1)
    }
}

// Mock Extensions
extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        
        let httpPostClient = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpPostClient)
        
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpPostClient, file: file, line: line)
        
        return (sut, httpPostClient)
    }        
}
