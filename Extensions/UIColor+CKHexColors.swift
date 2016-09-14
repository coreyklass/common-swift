//
//  UIColor+CKHexColors.swift
//  BlackBook
//
//  Created by Corey Klass on 04/01/2016
//  Copyright (c) 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {

    
    // constructor takes a hex color as a string in the format: "1289AB"
    convenience init(hexColor: String) {
        let redColor = UIColor.hexColorToFloat(hexColor.substringFromIndex(fromIndex: 0, toIndex: 1))
        let greenColor = UIColor.hexColorToFloat(hexColor.substringFromIndex(fromIndex: 2, toIndex: 3))
        let blueColor = UIColor.hexColorToFloat(hexColor.substringFromIndex(fromIndex: 4, toIndex: 5))
        
        self.init(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }

    
    
    // converts a hex color string to a float number
    fileprivate class func hexColorToFloat(_ hexColor: String) -> CGFloat {
        let char0 = hexColor.substringFromIndex(fromIndex: 0, toIndex: 0).uppercased()
        let char1 = hexColor.substringFromIndex(fromIndex: 1, toIndex: 1).uppercased()
        
        let value0 = UIColor.hexToInt(char0)
        let value1 = UIColor.hexToInt(char1)

        let colorValue = (value0 * 16) + value1
        
        let floatValue: CGFloat = CGFloat(colorValue) / 255.0
        
        return floatValue
    }
    
    
    // converts a hex character to an integer
    fileprivate class func hexToInt(_ hex: String) -> Int {
        var intValue = 0
        
        switch hex {
            case "A":
                intValue = 10
            case "B":
                intValue = 11
            case "C":
                intValue = 12
            case "D":
                intValue = 13
            case "E":
                intValue = 14
            case "F":
                intValue = 15
            default:
                intValue = Int(hex) ?? 0
        }
        
        return intValue
    }
    

    // returns the current color with a different alpha value
    func copyWithAlpha(alpha newAlpha: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: newAlpha)
        
        return color
    }
    
}


