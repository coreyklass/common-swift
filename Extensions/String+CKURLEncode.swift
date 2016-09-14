//
//  String+URLEncode.swift
//  MalcontentBoffin
//
//  Created by Corey Klass on 6/30/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation


extension String {
    
    
    func urlEncodedString() -> String {
        var urlEncodedString = self.replacingOccurrences(of: " ", with: "+")
        
        let customAllowedSet =  NSCharacterSet(charactersIn: "").inverted
        
        urlEncodedString = urlEncodedString.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        
        return urlEncodedString
    }
    

}
