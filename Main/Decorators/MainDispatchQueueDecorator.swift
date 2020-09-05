//
//  MainDispatchQueueDecorator.swift
//  Main
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class MainDispatchQueueDecorator<T> {
    private let instance: T
    
   public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainDispatchQueueDecorator: AddAccount where T: AddAccount {
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        
        instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
