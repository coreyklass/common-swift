//
//  TimeInterval+CK.swift
//  Watchboard
//
//  Created by Corey Klass on 10/24/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation


extension TimeInterval {
    
    // returns a text representation of the time interval
    func textValue() -> String {
        var dateParts = [TimeIntervalDatePart: Int]()

        var textValue = ""
        var runningTimeInterval = self
        
        dateParts[.day] = (Int(runningTimeInterval) / (24 * 60 * 60))
        runningTimeInterval -= Double(dateParts[.day]! * (24 * 60 * 60))
        
        dateParts[.hour] = (Int(runningTimeInterval) / (60 * 60))
        runningTimeInterval -= Double(dateParts[.hour]! * (60 * 60))
        
        dateParts[.minute] = (Int(runningTimeInterval) / 60)
        runningTimeInterval -= Double(dateParts[.minute]! * 60)
        
        dateParts[.second] = Int(runningTimeInterval)
        
        
        if (dateParts[.day]! != 0) {
            textValue =
                (textValue != "" ? ", " : "") +
                String(dateParts[.day]!) + " day" +
                (dateParts[.day]! != 1 ? "s" : "")
        }

        if (dateParts[.hour]! != 0) {
            textValue =
                (textValue != "" ? ", " : "") +
                String(dateParts[.hour]!) + " hour" +
                (dateParts[.hour]! != 1 ? "s" : "")
        }

        if (dateParts[.minute]! != 0) {
            textValue =
                (textValue != "" ? ", " : "") +
                String(dateParts[.minute]!) + " minute" +
                (dateParts[.minute]! != 1 ? "s" : "")
        }

        if ((dateParts[.second]! != 0) || (textValue == "")) {
            textValue =
                (textValue != "" ? ", " : "") +
                String(dateParts[.second]!) + " second" +
                (dateParts[.second]! != 1 ? "s" : "")
        }

        
        return textValue
    }
    
    
}



enum TimeIntervalDatePart {
    case day
    case hour
    case minute
    case second
}

