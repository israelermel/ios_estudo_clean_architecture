//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 18/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

import Alamofire
import Data

public final class AlamofireAdapter: HttpPostClient {
    
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData {
            dataReponse in
            
            guard let statusCode = dataReponse.response?.statusCode else { return completion(.failure(.noConnectivity)) }
            
            switch dataReponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }
}
