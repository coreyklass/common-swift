//
//  CKTableViewCell.swift
//  CountdownTimer
//
//  Created by Corey Klass on 10/16/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import UIKit

class CKTableViewCell: UITableViewCell {

    fileprivate var _layout: CKTableViewCellLayout = .label1
    
    var layout : CKTableViewCellLayout {
        get {
            return self._layout
        }
        set {
            self._layout = newValue
            self.reconcileContentViews()
            self.reconcileAccessoryViews()
            self.setNeedsUpdateConstraints()
        }
    }
    
    
    // padding around the inside of the cell
    static var cellPadding: CGFloat = 13.0
    
    fileprivate var _cellPadding: CGFloat = CKTableViewCell.cellPadding
    
    var cellPadding: CGFloat {
        get {
            return self._cellPadding
        }
        set {
            self._cellPadding = newValue
            self.setNeedsUpdateConstraints()
        }
    }

    // spacing between the UILabel and UITextField views
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
    
    
    
    // default value for the label 1 width; defaults to variable
    fileprivate var _label1Width : CGFloat = -1.0
    fileprivate var label1Constraint : NSLayoutConstraint?
    
    
    var label1Width : CGFloat {
        get {
            return self._label1Width
        }
        
        set {
            self._label1Width = newValue
            self.setNeedsUpdateConstraints()
        }
    }
    
    
    // multiple accessory views
    fileprivate var _accessoryView: UIView?
    fileprivate var _accessoryViews: [UIView]?
    
    var accessoryViews: [UIView] {
        get {
            let accessoryViews = self._accessoryViews ?? [UIView]()
            return accessoryViews
        }
        set {
            // remove the previous accessory views from their superview
            self._accessoryViews?.forEach({ (view: UIView) in
                view.removeFromSuperview()
            })
            
            // store the new views
            self._accessoryViews = newValue
            
            self.reconcileAccessoryViews()
            self.setNeedsUpdateConstraints()
            self.setNeedsLayout()
        }
    }
    
    
    fileprivate var _accessoryViewSpacing: CGFloat = 5.0

    var accessoryViewSpacing: CGFloat {
        get {
            return self._accessoryViewSpacing
        }
        set {
            self._accessoryViewSpacing = newValue
            
            self.setNeedsUpdateConstraints()
        }
    }
    
    
    fileprivate var _contentViewConstraints: [NSLayoutConstraint]?
    
    
    
    var label1: UILabel?
    var label2 : UILabel?
    var textField : UITextField?
    
    

    // convenience init
    init?(layout : CKTableViewCellLayout, reuseIdentifier : String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        self.layout = layout
        
        self.reconcileContentViews()
        self.setNeedsUpdateConstraints()
    }

    
    // standard init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // reconciles the content views
    fileprivate func reconcileContentViews() {
        
        // Handle Label1
        let showLabel1 =
            (self.layout == .label1) ||
            (self.layout == .labelHorizontal2) ||
            (self.layout == .labelVertical2) ||
            (self.layout == .labelWithText)
        
        // if we have label1 but don't want it
        if ((self.label1 != nil) && !showLabel1) {
            self.label1!.removeFromSuperview()
            self.label1 = nil
            
            self.setNeedsUpdateConstraints()
        }
        
        // if we don't have label1, but want it
        if ((self.label1 == nil) && showLabel1) {
            self.label1 = UILabel(frame: CGRect.zero)
            self.label1!.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview(self.label1!)
            
            self.setNeedsUpdateConstraints()
        }
        
        
        // Handle Label2
        let showLabel2 =
            (self.layout == .labelHorizontal2) ||
            (self.layout == .labelVertical2)
        
        // if we have label2 but don't want it
        if ((self.label2 != nil) && !showLabel2) {
            self.label2!.removeFromSuperview()
            self.label2 = nil
            
            self.setNeedsUpdateConstraints()
        }
        
        // if we don't have label2 but want it
        if ((self.label2 == nil) && showLabel2) {
            self.label2 = UILabel(frame: CGRect.zero)
            self.label2!.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview(self.label2!)
            
            self.setNeedsUpdateConstraints()
        }
        
        
        // Handle the Text Field
        let showTextField =
            (self.layout == .labelWithText) ||
            (self.layout == .textField)
        
        // if we have a text field but don't want it
        if ((self.textField != nil) && !showTextField) {
            self.textField!.removeFromSuperview()
            self.textField = nil
            
            self.setNeedsUpdateConstraints()
        }
        
        // if we don't have a text field but need it
        if ((self.textField == nil) && showTextField) {
            self.textField = UITextField(frame: CGRect.zero)
            self.textField!.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview(self.textField!)
            
            self.setNeedsUpdateConstraints()
        }
        
        
    }
    
    
    
    // reconciles the accessory views
    fileprivate func reconcileAccessoryViews() {
        var viewCount = self.accessoryViews.count
        
        if (self.layout == .empty) {
            viewCount = 0
        }
        
        // if there are no accessory views, but there is a container view
        if ((viewCount == 0) && (self._accessoryView != nil)) {
            self._accessoryView!.removeFromSuperview()
            self._accessoryView = nil

            self.setNeedsUpdateConstraints()
        }
        
        // if there are accessory views, but no container view
        if ((viewCount > 0) && (self._accessoryView == nil)) {
            self._accessoryView = UIView(frame: CGRect.zero)
            self._accessoryView!.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview(self._accessoryView!)
            
            self.setNeedsUpdateConstraints()
        }
        
        // set up constraints
        if (viewCount > 0) {
            self._accessoryView!.removeConstraints(self._accessoryView!.constraints)

            var lastView: UIView?
            
            let metrics: [String: CGFloat] = [
                "hSpacing": self.accessoryViewSpacing
            ]
            
            // loop over the accessory views
            self._accessoryViews!.forEach({ (indexView: UIView) in
                // add the accessory view to the parent view
                self._accessoryView!.addSubview(indexView)
                
                _ = indexView.constraintVerticalCenterInSuperview()
                
                var constraintTexts = [String]()
                var views = [String: UIView]()
                
                // if this is the first view
                if (lastView == nil) {
                    constraintTexts.append("H:|[indexView]")
                    constraintTexts.append("V:|[indexView]")
                    
                    views["indexView"] = indexView
                }
                
                // if this is not the first view
                else {
                    constraintTexts.append("H:[lastView]-(hSpacing)-[indexView]")
                    constraintTexts.append("V:[indexView]")
                    
                    views["lastView"] = lastView
                    views["indexView"] = indexView
                }
                
                let constraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                    constraintTexts,
                    options: nil,
                    metrics: metrics,
                    views: views)

                self._accessoryView!.addConstraints(constraints)
                
                lastView = indexView
            })
            
            // set up the last view
            var lastConstraintTexts = [String]()
            var lastViews = [String: UIView]()
            
            lastViews["lastView"] = lastView!
            lastConstraintTexts.append("H:[lastView]|")
            
            let lastConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                lastConstraintTexts,
                options: nil,
                metrics: metrics,
                views: lastViews)
            
            self._accessoryView!.addConstraints(lastConstraints)
        }
    }

    
    
    
    override func updateConstraints() {
        // set up the view and metrics dictionaries
        var views = [String: UIView]()
        var metrics = [String: CGFloat]()
        
        metrics["cellPadding"] = self.cellPadding
        metrics["fieldSpacing"] = self.fieldSpacing
        
        // is there a label1 width?
        metrics["label1Width"] = self.label1Width
        
        let hLabel1ConstraintText = self.label1Width == -1.0 ? "[label1]" : "[label1(==label1Width)]"
        let vLabel1ConstraintText = "[label1]"
        
        let hLabel2ConstraintText = "[label2]"
        let vLabel2ConstraintText = "[label2]"
        
        let hTextFieldConstraintText = "[textField]"
        let vTextFieldConstraintText = "[textField]"
        
        let hAccessoryViewConstraintText = (self._accessoryView != nil ? "[accessoryView]" : "")
        
        
        var constraintTexts = [String]()
        
        
        // if there is an accessory view
        if (self._accessoryView != nil) {
            views["accessoryView"] = self._accessoryView!
            
            constraintTexts.append("V:|-[accessoryView]-|")
        }
        
        
        if (self.layout == CKTableViewCellLayout.label1) {
            views["label1"] = self.label1
            
            constraintTexts.append("H:|-(cellPadding)-" + hLabel1ConstraintText)
            constraintTexts.append("H:" + hLabel1ConstraintText + hAccessoryViewConstraintText + "-(cellPadding)-|")
            
            constraintTexts.append("V:|-(cellPadding)-" + vLabel1ConstraintText + "-(cellPadding)-|")
        }

        else if (self.layout == CKTableViewCellLayout.labelHorizontal2) {
            views["label1"] = self.label1
            views["label2"] = self.label2

            constraintTexts.append("H:|-(cellPadding)-" + hLabel1ConstraintText)
            constraintTexts.append("H:" + hLabel1ConstraintText + "-(fieldSpacing)-" + hLabel2ConstraintText)
            constraintTexts.append("H:" + hLabel2ConstraintText + hAccessoryViewConstraintText + "-(cellPadding)-|")
            
            constraintTexts.append("V:|-(cellPadding)-" + vLabel1ConstraintText + "-(cellPadding)-|")
            constraintTexts.append("V:|-(cellPadding)-" + vLabel2ConstraintText + "-(cellPadding)-|")
        }

        
        else if (self.layout == CKTableViewCellLayout.labelVertical2) {
            views["label1"] = self.label1
            views["label2"] = self.label2
            
            constraintTexts.append("H:|-(cellPadding)-" + hLabel1ConstraintText + hAccessoryViewConstraintText + "-(cellPadding)-|")
            constraintTexts.append("H:|-(cellPadding)-" + hLabel2ConstraintText + hAccessoryViewConstraintText + "-(cellPadding)-|")
            
            constraintTexts.append("V:|-(cellPadding)-" + vLabel1ConstraintText + "-(fieldSpacing)-" + vLabel2ConstraintText + "-(cellPadding)-|")
        }

        
        else if (self.layout == CKTableViewCellLayout.labelWithText) {
            views["label1"] = self.label1
            views["textField"] = self.textField
            
            constraintTexts.append("H:|-(cellPadding)-" + hLabel1ConstraintText + "-(fieldSpacing)-" + hTextFieldConstraintText)
            constraintTexts.append("H:" + hTextFieldConstraintText + hAccessoryViewConstraintText + "-(cellPadding)-|")
            
            constraintTexts.append("V:|-(cellPadding)-" + vLabel1ConstraintText + "-(cellPadding)-|")
            constraintTexts.append("V:|" + vTextFieldConstraintText + "|")
        }
        

        else if (self.layout == CKTableViewCellLayout.textField) {
            views["textField"] = self.textField
            
            constraintTexts.append("|-(cellPadding)-" + hTextFieldConstraintText + hAccessoryViewConstraintText + "-(cellPadding)-|")
            constraintTexts.append("V:|" + vTextFieldConstraintText + "|")

            if (self.textField!.font != nil) {
                let textFieldHeight: CGFloat = round(self.textField!.font?.lineHeight ?? 0) + (self.cellPadding * 2.0)
                
                metrics["textFieldHeight"] = textFieldHeight
                constraintTexts.append("V:[textField(==textFieldHeight)]")
            }
        }

        
        // if any constraints were specified
        if (self._layout != .empty) {
            // remove existing constraints
            if (self._contentViewConstraints != nil) {
                self.contentView.removeConstraints(self._contentViewConstraints!)
                self._contentViewConstraints = nil
            }
            
            // add new constraints
            let cellConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                constraintTexts,
                options: nil,
                metrics: metrics,
                views: views)
            
            cellConstraints.forEach { (constraint: NSLayoutConstraint) -> () in
                constraint.priority = 999
            }
            
            self.contentView.addConstraints(cellConstraints)
            
            self._contentViewConstraints = cellConstraints
        }
        
        
        // call the super function
        super.updateConstraints()
    }
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}




enum CKTableViewCellLayout : Int {
    case label1 = 10
    case labelHorizontal2 = 20
    case labelVertical2 = 30
    case labelWithText = 40
    case textField = 50
    case empty = 60
}

