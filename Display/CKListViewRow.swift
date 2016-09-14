//
//  CKListViewRow.swift
//  BlackBook
//
//  Created by Corey Klass on 3/10/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class CKListViewRow: UIView {

    
    // type of the view
    fileprivate var _type: CKListViewRowType?
    
    var type: CKListViewRowType {
        get {
            return self._type!
        }
        set {
            let type = newValue
            
            // if we're changing the type
            if (self._type != type) {
                self._type = type
                self.reconcileSubviews()
            }
        }
    }
    
    // labels and text fields
    var label1: CKLabel?
    var label2: CKLabel?
    var textField: UITextField?
    
    // field spacing
    fileprivate var _fieldSpacing: CGFloat = 10.0
    
    var fieldSpacing: CGFloat {
        get {
            return self._fieldSpacing
        }
        
        set {
            self._fieldSpacing = newValue
            self.setNeedsUpdateConstraints()
        }
    }
    

    // label 1 width
    fileprivate var _label1Width: CGFloat = 100.0
    
    var label1Width: CGFloat {
        get {
            return self._label1Width
        }
        
        set {
            self._label1Width = newValue
            self.setNeedsUpdateConstraints()
        }
    }
    

    // view padding
    fileprivate var _viewPadding = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)

    var viewPadding: UIEdgeInsets {
        get {
            return self._viewPadding
        }
        
        set {
            self._viewPadding = newValue
            self.setNeedsUpdateConstraints()
        }
    }


    // accessory view spacing
    fileprivate var _accessoryViewSpacing: CGFloat = 10.0
    
    var accessoryViewSpacing: CGFloat {
        get {
            return self._accessoryViewSpacing
        }
        
        set {
            self._accessoryViewSpacing = newValue
            self.setNeedsUpdateConstraints()
        }
    }
    
    
    // accessory views
    fileprivate var _accessoryViewContainer: UIView?
    fileprivate var _accessoryViews: [UIView]?
    
    var accessoryViews: [UIView]? {
        get {
            return self._accessoryViews
        }
        set {
            // if we need to create an accessory view container
            if ((newValue?.count > 0) && (self._accessoryViewContainer == nil)) {
                self._accessoryViewContainer = UIView(frame: CGRect.zero)
                self._accessoryViewContainer!.translatesAutoresizingMaskIntoConstraints = false
                self._accessoryViewContainer!.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: UILayoutConstraintAxis.horizontal)
                
                self.addSubview(self._accessoryViewContainer!)
            }
            
            // if we need to remove the accessory view container
            else if (((newValue?.count ?? 0) == 0) && (self._accessoryViewContainer != nil)) {
                self._accessoryViewContainer!.removeFromSuperview()
                self._accessoryViewContainer = nil
            }
            
            
            // look for view deletions
            self._accessoryViews?.forEach({ (view: UIView) in
                let viewPersists = (newValue?.contains(view) ?? false)
                
                if (!viewPersists) {
                    view.removeFromSuperview()
                }
            })
            
            // look for view insertions
            newValue?.forEach({ (view: UIView) in
                let viewExists = (self._accessoryViews?.contains(view) ?? false)
                
                if (!viewExists) {
                    self._accessoryViewContainer!.addSubview(view)
                }
            })
            
            // store the new accessory views and request a constraint update
            self._accessoryViews = newValue
            self.setNeedsUpdateConstraints()
        }
    }
    
    
    
    
    
    // constructor
    init(type: CKListViewRowType) {
        super.init(frame: CGRect.zero)
        
        self.type = type
    }

    
    // unused constructor
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // reconcile subviews
    fileprivate func reconcileSubviews() {
        let type = self._type!
        
        // what do we do with label1
        let allowLabel1 =
            (type == CKListViewRowType.label1) ||
            (type == CKListViewRowType.label1HorizontalTextField) ||
            (type == CKListViewRowType.label1VerticalTextField) ||
            (type == CKListViewRowType.label2Horizontal) ||
            (type == CKListViewRowType.label2Vertical)
        
        // create a new label
        if (allowLabel1 && (self.label1 == nil)) {
            self.label1 = CKLabel(frame: CGRect.zero)
            self.label1!.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.label1!)
        }
            
        // remove the label
        else if (!allowLabel1 && (self.label1 != nil)) {
            self.label1!.removeFromSuperview()
            self.label1 = nil
        }
        
        
        // what do we do with label2
        let allowLabel2 =
            (type == CKListViewRowType.label2Horizontal) ||
            (type == CKListViewRowType.label2Vertical)
        
        // create a new label
        if (allowLabel2 && (self.label2 == nil)) {
            self.label2 = CKLabel(frame: CGRect.zero)
            self.label2!.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.label2!)
        }
            
        // remove the label
        else if (!allowLabel2 && (self.label2 != nil)) {
            self.label2!.removeFromSuperview()
            self.label2 = nil
        }
        
        
        
        // what do we do with the text field
        let allowTextField =
            (type == CKListViewRowType.label1HorizontalTextField) ||
            (type == CKListViewRowType.label1VerticalTextField)
        
        // create a new text field
        if (allowTextField && (self.textField == nil)) {
            self.textField = UITextField(frame: CGRect.zero)
            self.textField!.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.textField!)
        }
            
        // remove the text field
        else if (!allowTextField && (self.textField != nil)) {
            self.textField!.removeFromSuperview()
            self.textField = nil
        }
        
        // re-layout the subviews
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        // update the constraints
        self.setNeedsUpdateConstraints()
    }
    
    
    
    
    override func updateConstraints() {
        // remove existing constraints
        self.removeConstraints(self.constraints)
        
        // constraint stuff
        var views = [String: UIView]()
        
        let metrics: [String: CGFloat] = [
            "viewPaddingTop": self.viewPadding.top,
            "viewPaddingBottom": self.viewPadding.bottom,
            "viewPaddingLeft": self.viewPadding.left,
            "viewPaddingRight": self.viewPadding.right,
            "fieldSpacing": self.fieldSpacing,
            "label1Width": self.label1Width
        ]
        
        var constraintTexts = [String]()
        let includeAccessoryView = (self._accessoryViewContainer != nil)
        
        if (includeAccessoryView) {
            views["accessoryView"] = self._accessoryViewContainer!

            // center the accessory view container in the superview
            _ = self._accessoryViewContainer!.constraintVerticalCenterInSuperview()
            
            // delete all accessory view constraints
            self._accessoryViewContainer!.removeConstraints(self._accessoryViewContainer!.constraints)
            
            var prevAccessoryView: UIView?
            var lastAccessoryView: UIView?
            
            self._accessoryViews?.forEach({ (accessoryView: UIView) in
                // high content hugging priority = don't increase the size of the accessory view
                accessoryView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
                
                var accessoryViews = [String: UIView]()
                var accessoryMetrics = [String: CGFloat]()
                var accessoryConstraintTexts = [String]()
                
                accessoryViews["currentView"] = accessoryView
                accessoryMetrics["accessoryViewSpacing"] = self.accessoryViewSpacing
                
                accessoryConstraintTexts.append("V:|[currentView]|")
                
                // this is the first accessory view
                if (prevAccessoryView == nil) {
                    accessoryConstraintTexts.append("H:|[currentView]")
                }
                
                // this is not the first accessory view
                else {
                    accessoryViews["prevView"] = prevAccessoryView
                    accessoryConstraintTexts.append("H:[prevView]-(accessoryViewSpacing)-[currentView]")
                }

                let accessoryConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                    accessoryConstraintTexts,
                    options: nil,
                    metrics: accessoryMetrics,
                    views: accessoryViews)
                
                self._accessoryViewContainer!.addConstraints(accessoryConstraints)
                
                prevAccessoryView = accessoryView
                lastAccessoryView = accessoryView
            })
            
            
            // if there was a last accessory view
            if (lastAccessoryView != nil) {
                let lastAccessoryViews: [String: UIView] = ["lastView": lastAccessoryView!]
                let lastAccessoryMetrics = [String: CGFloat]()
                let lastAccessoryConstraintTexts = ["H:[lastView]|"]
                
                let lastAccessoryConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                    lastAccessoryConstraintTexts,
                    options: nil,
                    metrics: lastAccessoryMetrics,
                    views: lastAccessoryViews)
                
                self._accessoryViewContainer!.addConstraints(lastAccessoryConstraints)
            }
        }
        
        
        // 1 label
        if (type == .label1) {
            views["label1"] = self.label1!
            
            constraintTexts.append("H:|-(viewPaddingLeft)-[label1]")
            constraintTexts.append("V:|-(viewPaddingTop)-[label1]-(viewPaddingBottom)-|")
            
            if (includeAccessoryView) {
                constraintTexts.append("H:[label1]-(fieldSpacing)-[accessoryView]-(viewPaddingRight)-|")
            }
            else {
                constraintTexts.append("H:[label1]-(viewPaddingRight)-|")
            }
        }
            
        // 2 labels, horizontal
        else if ((type == .label2Horizontal) || (type == .label1HorizontalTextField))  {
            views["label1"] = self.label1!
            views["label2"] = (type == .label2Horizontal) ? self.label2! : self.textField!
            
            constraintTexts.append("H:|-(viewPaddingLeft)-[label1]-(fieldSpacing)-[label2]")
            constraintTexts.append("V:|-(viewPaddingTop)-[label1]-(>=viewPaddingBottom)-|")
            constraintTexts.append("V:|-(viewPaddingTop)-[label2]-(>=viewPaddingBottom)-|")
            
            if (self.label1Width != -1) {
                constraintTexts.append("[label1(==label1Width)]")
            }
            
            if (includeAccessoryView) {
                constraintTexts.append("H:[label2]-(fieldSpacing)-[accessoryView]-(viewPaddingRight)-|")
            }
            else {
                constraintTexts.append("H:[label2]-(viewPaddingRight)-|")
            }
        }
            
        // 2 labels, vertical
        else if (type == CKListViewRowType.label2Vertical) {
            views["label1"] = self.label1!
            views["label2"] = (type == .label2Vertical) ? self.label2! : self.textField!
            
            constraintTexts.append("H:|-(viewPaddingLeft)-[label1]")
            constraintTexts.append("H:|-(viewPaddingLeft)-[label2]")
            constraintTexts.append("V:|-(viewPaddingTop)-[label1]-(fieldSpacing)-[label2]-(viewPaddingBottom)-|")
            
            if (includeAccessoryView) {
                constraintTexts.append("H:[label1]-(fieldSpacing)-[accessoryView]-(viewPaddingRight)-|")
                constraintTexts.append("H:[label2]-(fieldSpacing)-[accessoryView]-(viewPaddingRight)-|")
            }
            else {
                constraintTexts.append("H:[label1]-(viewPaddingRight)-|")
                constraintTexts.append("H:[label2]-(viewPaddingRight)-|")
            }
        }
        
        // translate text into constraints
        let constraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
            constraintTexts,
            options: nil,
            metrics: metrics,
            views: views)
        
        
        constraints.forEach { (constraint: NSLayoutConstraint) -> () in
            constraint.priority = 999
        }
        
        // add the constaints to the view
        self.addConstraints(constraints)
        
        super.updateConstraints()
    }
    
    
    
}



// the type of list view
enum CKListViewRowType: Int {
    case label1 = 10
    case label2Horizontal = 20
    case label2Vertical = 30
    case label1HorizontalTextField = 40
    case label1VerticalTextField = 50
    case textField = 60
}


