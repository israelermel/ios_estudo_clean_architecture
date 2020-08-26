//
//  TestsFactories.swift
//  DataTests
//
//  Created by Israel Ermel on 17/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

func makeUrl(url: String = "http://any-url.com") -> URL {
   return URL(string: url)!
}

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\": \"Israel\"}".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeEmptyData() -> Data {
    return Data()
}
