//
//  CKLabel.swift
//  BlackBook
//
//  Created by Corey Klass on 6/8/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit

class CKLabel: UILabel {

    // constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // tap handler
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    // copy text
    fileprivate var _copyText: String?
    var copyText: String {
        get {
            let copyText = (self._copyText ?? self.text ?? "")
            return copyText
        }
        set {
            self._copyText = newValue
        }
    }
    
    // menu
    fileprivate var _menu: UIMenuController?
    
    var menuView: UIView?
    
    
    
    // attaches the tap handler to the label
    func attachTapHandler() {
        if (self.tapGestureRecognizer == nil) {
            self.isUserInteractionEnabled = true
            
            self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: .DidTapLabel)
            
            self.addGestureRecognizer(self.tapGestureRecognizer!)
        }
    }
    
    
    func attachTapHandlerWithMenuView(_ menuView: UIView) {
        self.attachTapHandler()
        
        self.menuView = menuView
    }
    
    
    // removes the tap handler
    func removeTapHandler() {
        if (self.tapGestureRecognizer != nil) {
            self.removeGestureRecognizer(self.tapGestureRecognizer!)
            self.tapGestureRecognizer = nil
        }
    }
    
    
    
    // handles the tap gesture
    func didTapLabel(_ gesture: UITapGestureRecognizer) {
        // if the current label is the first responder, resign the first responder
        if (self._menu?.isMenuVisible == true) {
            self.resignFirstResponder()
            
            self._menu!.setMenuVisible(false, animated: true)
            
            self._menu = nil
        }
        
        // if the current label is not the first responder, become the first responder
        else {
            self.becomeFirstResponder()

            let menuView: UIView = self.menuView ?? self
            
            // how wide is the text in the label
            let maxSize = CGSize(width: menuView.frame.size.width, height: menuView.frame.size.height)
            let size = menuView.sizeThatFits(maxSize)
            let contentRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
            
            self._menu = UIMenuController.shared
            
            self._menu!.setTargetRect(contentRect, in: menuView.superview!)
            self._menu!.setMenuVisible(true, animated: true)
        }
    }
    
    
    
    // copy
/*
    override func copy(_ sender: AnyObject?) {
        UIPasteboard.general.string = self.copyText
    }
*/    
    
    // can become a first responder
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    
    
}



private extension Selector {
    
    static let DidTapLabel = #selector(CKLabel.didTapLabel(_:))
    
}


