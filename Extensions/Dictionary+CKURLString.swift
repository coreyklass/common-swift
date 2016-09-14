//
//  Dictionary+CKURL.swift
//  MalcontentBoffin
//
//  Created by Corey Klass on 6/30/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation


extension Dictionary {
    
    func toURLString() -> String {
        var urlString = ""
        
        for (paramNameObject, paramValueObject) in self {
            let paramNameEncoded = (paramNameObject as! String).urlEncodedString()
            let paramValueEncoded = (paramValueObject as! String).urlEncodedString()
            
            let oneUrlPiece = paramNameEncoded + "=" + paramValueEncoded
            
            urlString = urlString + (urlString == "" ? "" : "&") + oneUrlPiece
        }
        
        return urlString
    }
    
}
