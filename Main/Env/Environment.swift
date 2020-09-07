//
//  Environment.swift
//  Main
//
//  Created by Israel Ermel on 05/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public final class Environment {
    
    public enum EnvironmentVariables :String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
