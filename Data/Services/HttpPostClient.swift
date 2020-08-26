//
//  HttpPostClient.swift
//  Data
//
//  Created by Israel Ermel on 15/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol HttpPostClient{
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
