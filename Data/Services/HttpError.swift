//
//  HttpError.swift
//  Data
//
//  Created by Israel Ermel on 15/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public enum HttpError : Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
