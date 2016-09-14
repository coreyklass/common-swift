//
//  String+CKURLAppend.swift
//  MalcontentBoffin
//
//  Created by Corey Klass on 7/3/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation


extension String {
    
    func urlStringByAppendingQueryString(queryString : String) -> String {
        return self + (self.contains("?") ? "&" : "?") + queryString
    }
    
    
}


