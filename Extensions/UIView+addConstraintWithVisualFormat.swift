//
//  UIView+addConstraintWithVisualFormat.swift
//  BlackBook
//
//  Created by Corey Klass on 12/25/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension UIView {

    
    
    // single, options, Swift
    func addConstraintsWithVisualFormat(
        _ format: String,
        options: NSLayoutFormatOptions?,
        metrics: [String: CGFloat],
        views: [String: UIView]) -> [NSLayoutConstraint] {

        let constraints = self.addMultipleConstraintsWithVisualFormat(
            [format],
            options: options,
            metrics: metrics,
            views: views)
        
        return constraints
    }

    
    // adds multiple constraints via visual format
    func addMultipleConstraintsWithVisualFormat(
        _ formats: [String],
        options: NSLayoutFormatOptions?,
        metrics: [String: CGFloat],
        views: [String: UIView]) -> [NSLayoutConstraint] {

        let constraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
            formats,
            options: options,
            metrics: metrics,
            views: views)

        self.addConstraints(constraints)
        
        return constraints
    }

    

    // sets the view to fill the superview
    func constraintFillSuperview() -> [NSLayoutConstraint] {
        return self.constraintFillSuperviewWithPadding(0.0)
    }
    
    
    func constraintFillSuperviewWithPadding(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let metrics: [String: CGFloat] = [
            "padding": padding
        ]
        
        let views = ["subview": self]
        
        let constraintTexts = [
            "H:|-(padding)-[subview]-(padding)-|",
            "V:|-(padding)-[subview]-(padding)-|"
        ]
        
        let constraints = self.superview!.addMultipleConstraintsWithVisualFormat(
            constraintTexts,
            options: nil,
            metrics: metrics,
            views: views)
        
        return constraints
    }
    

    
    // centers the view vertically
    func constraintVerticalCenterInSuperview() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        if (self.superview != nil) {
            let constraint = NSLayoutConstraint(
                item: self,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.superview!,
                attribute: NSLayoutAttribute.centerY,
                multiplier: 1,
                constant: 0.0)
            
            self.superview!.addConstraint(constraint)
            
            constraints.append(constraint)
        }
        
        else {
            print("Warning: No superview set for view: " + self.description)
        }
        
        return constraints
    }
    
    
    // centers the view horizontally
    func constraintHorizontalCenterInSuperview() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        if (self.superview != nil) {
            let constraint = NSLayoutConstraint(
                item: self,
                attribute: NSLayoutAttribute.centerX,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.superview!,
                attribute: NSLayoutAttribute.centerX,
                multiplier: 1,
                constant: 0.0)
            
            self.superview!.addConstraint(constraint)
            
            constraints.append(constraint)
        }

        else {
            print("Warning: No superview set for view: " + self.description)
        }
        
        return constraints
    }
    
    
    
    // set height constraint
    func setConstraintHeight(_ height: CGFloat) -> [NSLayoutConstraint] {
        let metrics: [String: CGFloat] = [
            "height": height
        ]
        
        let views: [String: UIView] = [
            "subview": self
        ]
        
        let constraintTexts = [
            "V:[subview(==height)]"
        ]
        
        let constraints = self.superview!.addMultipleConstraintsWithVisualFormat(
            constraintTexts,
            options: nil,
            metrics: metrics,
            views: views)
        
        return constraints
    }
    
    
    // set width constraint
    func setConstraintWidth(_ width: CGFloat) -> [NSLayoutConstraint] {
        let metrics: [String: CGFloat] = [
            "width": width
        ]
        
        let views: [String: UIView] = [
            "subview": self
        ]
        
        let constraintTexts = [
            "H:[subview(==width)]"
        ]
        
        let constraints = self.superview!.addMultipleConstraintsWithVisualFormat(
            constraintTexts,
            options: nil,
            metrics: metrics,
            views: views)
        
        return constraints
    }
    
    
    
    func constraintAttachToSide(_ side: CKViewConstraintAttachSide, withPadding padding: CGFloat) -> [NSLayoutConstraint] {
        let metrics: [String: CGFloat] = [
            "padding": padding
        ]
        
        let views: [String: UIView] = [
            "view": self
        ]
        
        var constraintTexts = [String]()
        
        if (side == .top) {
            constraintTexts.append("V:|-(padding)-[view]")
        }
        else if (side == .bottom) {
            constraintTexts.append("V:[view]-(padding)-|")
        }
        else if (side == .left) {
            constraintTexts.append("H:|-(padding)-[view]")
        }
        else if (side == .right) {
            constraintTexts.append("H:[view]-(padding)-|")
        }
        
        
        let constraints = self.superview!.addMultipleConstraintsWithVisualFormat(
            constraintTexts,
            options: nil,
            metrics: metrics,
            views: views)
        
        return constraints
    }
    
    
    
}


enum CKViewConstraintAttachSide {
    case top
    case bottom
    case left
    case right
}



extension NSLayoutConstraint {
    
    
    class func multipleConstraintsWithVisualFormat(
        _ formats: [String],
        options: NSLayoutFormatOptions?,
        metrics: [String: CGFloat],
        views: [String: UIView]) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()

        let cleanOptions = (options != nil ? options! : NSLayoutFormatOptions(rawValue: 0))
        
        // loop over all of the formats, adding them
        for format in formats {
            let indexConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: format,
                options: cleanOptions,
                metrics: metrics,
                views: views)
            
            for indexConstraint in indexConstraints {
                constraints.append(indexConstraint)
            }
        }
        
        return constraints
    }
    
    
}


