//
//  CKKeyboardAccessoryView.swift
//  ORHP-Toolbox
//
//  Created by Corey Klass on 9/4/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit

class CKKeyboardAccessoryView: UIView {

    static let defaultHeight: CGFloat = 44.0
    static let defaultPadding: CGFloat = 10.0
    
    var subViewSpacing: CGFloat = 10.0
    var leftPadding: CGFloat = CKKeyboardAccessoryView.defaultPadding
    var rightPadding: CGFloat = CKKeyboardAccessoryView.defaultPadding
    
    
    // left side views
    fileprivate var _leftSideViews: [UIView]?

    var leftSideViews: [UIView]? {
        get {
            let leftSideViews = self._leftSideViews
            return leftSideViews
        }
        set {
            // loop over the existing left side views and remove them from the superview
            self._leftSideViews?.forEach({ (view: UIView) in
                view.removeFromSuperview()
            })

            // add the new views as subviews
            self._leftSideViews = newValue
            
            self._leftSideViews?.forEach({ (view: UIView) in
                self.addSubview(view)
            })
            
            self.reconcileFrame()
            
            self.setNeedsUpdateConstraints()
            self.setNeedsLayout()
            
            self.updateConstraintsIfNeeded()
            self.layoutIfNeeded()
        }
    }

    
    
    // right side views
    fileprivate var _rightSideViews: [UIView]?
    
    var rightSideViews: [UIView]? {
        get {
            let rightSideViews = self._rightSideViews
            return rightSideViews
        }
        set {
            // loop over the existing left side views and remove them from the superview
            self._rightSideViews?.forEach({ (view: UIView) in
                view.removeFromSuperview()
            })
            
            // add the new views as subviews
            self._rightSideViews = newValue
            
            self._rightSideViews?.forEach({ (view: UIView) in
                self.addSubview(view)
            })
            
            self.reconcileFrame()

            self.setNeedsUpdateConstraints()
            self.setNeedsLayout()
            
            self.updateConstraintsIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
    
    fileprivate var _leftSideConstraints: [NSLayoutConstraint]?
    fileprivate var _rightSideConstraints: [NSLayoutConstraint]?
    
    
    
    // constructor
    init() {
        super.init(frame: CGRect.zero)
        
        self.reconcileFrame()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // reconciles the view frame
    fileprivate func reconcileFrame() {
        let screenWidth = UIScreen.main.bounds.size.width

        let currentHeight = self.frame.size.height
        var viewHeight: CGFloat = 0.0
        
        // loop over the views
        var views = [UIView]()
        
        if (self._leftSideViews != nil) {
            views.append(contentsOf: self._leftSideViews!)
        }
        
        if (self._rightSideViews != nil) {
            views.append(contentsOf: self._rightSideViews!)
        }
        
        // loop over the views
        views.forEach { (view: UIView) in
            var testHeight: CGFloat?

            // if this is a button
            if let button = (view as? UIButton) {
                testHeight = round((button.titleLabel?.font.lineHeight ?? 0.0) * 2.0)
            }
            
            // if this is an image
            else if let imageView = (view as? UIImageView) {
                testHeight = round((imageView.image?.size.height ?? 0.0) * 2.0)
            }
            
            // if the new height is higher, reset it
            if ((testHeight ?? 0) > viewHeight) {
                viewHeight = testHeight!
            }
        }

        // if the view height is less than the default
        if (viewHeight < CKKeyboardAccessoryView.defaultHeight) {
            viewHeight = CKKeyboardAccessoryView.defaultHeight
        }
        
        
        // if there is a view height, and it's different
        if ((viewHeight > 0) && (viewHeight != currentHeight)) {
            self.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: viewHeight)
        }
    }
    
    
    
    
    // layout subviews
    override func layoutSubviews() {
        
        
        super.layoutSubviews()
    }
    
    
    // update constraints
    override func updateConstraints() {
        
        // remove existing constraints
        if (self._leftSideConstraints != nil) {
            self.removeConstraints(self._leftSideConstraints!)
        }
        
        if (self._rightSideConstraints != nil) {
            self.removeConstraints(self._rightSideConstraints!)
        }
        
        
        // pull out left side constraints
        self._leftSideConstraints = {() -> [NSLayoutConstraint] in
            var constraints = [NSLayoutConstraint]()
            var prevView: UIView?
            
            for viewIndex in 0..<(self._leftSideViews?.count ?? 0) {
                let view = self._leftSideViews![viewIndex]
                
                // if this is the first view
                if (viewIndex == 0) {
                    let metrics: [String: CGFloat] = [
                        "leftPadding": self.leftPadding
                    ]
                    
                    let views: [String: UIView] = [
                        "view": view
                    ]
                    
                    let constraintTexts = [
                        "H:|-(leftPadding)-[view]"
                    ]
                    
                    let indexConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                        constraintTexts,
                        options: nil,
                        metrics: metrics,
                        views: views)
                    
                    constraints.append(contentsOf: indexConstraints)
                }
                
                // if this is a remaining view
                else {
                    let metrics: [String: CGFloat] = [
                        "subViewSpacing": self.subViewSpacing
                    ]
                    
                    let views: [String: UIView] = [
                        "view": view,
                        "prevView": prevView!
                    ]
                    
                    let constraintTexts = [
                        "H:[prevView]-(subViewSpacing)-[view]"
                    ]
                    
                    let indexConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                        constraintTexts,
                        options: nil,
                        metrics: metrics,
                        views: views)
                    
                    constraints.append(contentsOf: indexConstraints)
                }

                constraints.append(contentsOf: view.constraintVerticalCenterInSuperview())

                prevView = view
            }

            self.addConstraints(constraints)

            return constraints
        }()
        
        
        
        // pull out right side constraints
        self._rightSideConstraints = {() -> [NSLayoutConstraint] in
            var constraints = [NSLayoutConstraint]()
            var prevView: UIView?
            
            for viewIndex in 0..<(self._rightSideViews?.count ?? 0) {
                let view = self._rightSideViews![viewIndex]
                
                // if this is the first view
                if (viewIndex == 0) {
                    let metrics: [String: CGFloat] = [
                        "rightPadding": self.rightPadding
                    ]
                    
                    let views: [String: UIView] = [
                        "view": view
                    ]
                    
                    let constraintTexts = [
                        "H:[view]-(rightPadding)-|"
                    ]
                    
                    let indexConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                        constraintTexts,
                        options: nil,
                        metrics: metrics,
                        views: views)
                    
                    constraints.append(contentsOf: indexConstraints)
                }
                    
                    // if this is a remaining view
                else {
                    let metrics: [String: CGFloat] = [
                        "subViewSpacing": self.subViewSpacing
                    ]
                    
                    let views: [String: UIView] = [
                        "view": view,
                        "prevView": prevView!
                    ]
                    
                    let constraintTexts = [
                        "H:[view]-(subViewSpacing)-[prevView]"
                    ]
                    
                    let indexConstraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                        constraintTexts,
                        options: nil,
                        metrics: metrics,
                        views: views)
                    
                    constraints.append(contentsOf: indexConstraints)
                }

                constraints.append(contentsOf: view.constraintVerticalCenterInSuperview())

                prevView = view
            }

            self.addConstraints(constraints)

            return constraints
            }()
        
        
        super.updateConstraints()
    }
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
