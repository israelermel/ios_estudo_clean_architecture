//
//  Storyboarded.swift
//  iOSUi
//
//  Created by Israel Ermel on 03/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    public static func instantiate() -> Self {
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        
        return sb.instantiateViewController(identifier: vcName) as! Self
    }
}
