//
//  String+CKDate.swift
//  MalcontentBoffin
//
//  Created by Corey Klass on 6/29/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation


extension String {
    
    /*
    
    iOS 7:
    http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
    
    */
    
    func dateWithFormat(dateFormat:String) -> NSDate {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat;
        
        var date = dateFormatter.dateFromString(self)
        
        return date!
    }
    
}


