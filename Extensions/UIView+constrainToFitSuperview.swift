//
//  UIView+constrainToFitSuperview.swift
//  BlackBook
//
//  Created by Corey Klass on 10/27/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func constrainToFitSuperview() {

        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // set up the view and metrics dictionaries
        var superview = self.superview!
        
        var viewDict = NSMutableDictionary()
        var metricsDict = NSMutableDictionary()
        
        viewDict.setValue(self, forKey: "subview")
        
        superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[subview]|", options: nil, metrics: metricsDict.swiftDictionary(), views: viewDict.swiftDictionary()))
        superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subview]|", options: nil, metrics: metricsDict.swiftDictionary(), views: viewDict.swiftDictionary()))
        
    }
    
    
    
}
