//
//  Double+CK.swift
//  ORHP-Toolbox
//
//  Created by Corey Klass on 9/9/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension Double {

    
    // returns the number formatted for dollars
    var dollarFormat: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.groupingSeparator = ","
            numberFormatter.groupingSize = 3
            numberFormatter.usesGroupingSeparator = true
            
            let number = NSNumber(value: self)
            
            let numberText = "$" + numberFormatter.string(from: number)!
            
            return numberText
        }
    }
    
    
}

