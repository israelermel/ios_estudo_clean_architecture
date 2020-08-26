//
//  TestsExtensions.swift
//  DataTests
//
//  Created by Israel Ermel on 17/08/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import XCTest
import Foundation

extension XCTestCase {
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
