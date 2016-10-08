//
//  Date+CK.swift
//  Watchboard
//
//  Created by Corey Klass on 10/3/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation


extension Date {

    // convenience functions
    func isBefore(date: Date) -> Bool {
        let result = (self.compare(date) == ComparisonResult.orderedAscending)
        return result
    }
    
    
    func isEqualTo(date: Date) -> Bool {
        let result = (self.compare(date) == ComparisonResult.orderedSame)
        return result
    }
    
    
    func isAfter(date: Date) -> Bool {
        let result = (self.compare(date) == ComparisonResult.orderedDescending)
        return result
    }
    
    
}


