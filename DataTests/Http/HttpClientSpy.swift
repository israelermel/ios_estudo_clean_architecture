//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Israel Ermel on 17/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data

class HttpClientSpy : HttpPostClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWith(error : HttpError) {
        completion?(.failure(error))
    }
    
    func completeWith(data : Data) {
        completion?(.success(data))
    }
}
