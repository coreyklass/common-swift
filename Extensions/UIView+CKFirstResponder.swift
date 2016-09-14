//
//  UIView+CKFirstResponder.swift
//  BlackBook
//
//  Created by Corey Klass on 4/10/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    
    
    // finds the first responder
    func findFirstResponder() -> UIView? {
        var firstResponder : UIView?
        
        // if the current view is the first responder
        if (self.isFirstResponder) {
            firstResponder = self
        }
            
        // the current view is not the first responder
        else {
            let subviews = self.subviews
            var subviewIndex = 0
            
            // while the first responder hasn't been found yet
            while ((firstResponder == nil) && (subviewIndex < subviews.count)) {
                let oneSubview = subviews[subviewIndex]
                
                firstResponder = oneSubview.findFirstResponder()
                
                subviewIndex += 1
            }
        }
        
        return firstResponder
    }
    
    
    
    // looks for the first responder and resigns it
    func findAndResignFirstResponder() -> UIView? {
        let firstResponder = self.findFirstResponder()
        
        firstResponder?.resignFirstResponder()
        
        return firstResponder
    }
    
    
}



