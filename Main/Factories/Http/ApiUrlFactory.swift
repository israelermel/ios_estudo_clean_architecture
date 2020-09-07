//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Israel Ermel on 06/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

func makeApiUrl(path: String) -> URL {
   return URL(string: "\(Environment.variable(.apiBaseUrl))/\(path)")!
}
   
