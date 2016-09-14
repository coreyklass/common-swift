//
//  NSDictionary+SwiftDictionary.swift
//  BlackBook
//
//  Created by Corey Klass on 3/8/15.
//  Copyright (c) 2015 Corey Klass. All rights reserved.
//

import Foundation



extension NSDictionary {
    
    func swiftDictionary() -> [NSObject : AnyObject] {
        var dict = (self as [NSObject : AnyObject])
        return dict
    }
    
}
