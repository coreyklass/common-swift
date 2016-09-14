//
//  CKKeyboardScroller.swift
//  BlackBook
//
//  Created by Corey Klass on 11/5/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import UIKit

class CKKeyboardScroller: NSObject {
   
    var scrollView : UIScrollView
    var scrollViewPreviousContentInset : UIEdgeInsets?
    var defaultScrollViewContentInset: UIEdgeInsets?
    
    var viewOfInterest : UIView?
    
    var keyboardSize: CGRect?
    var keyboardIsShown: Bool = false
    
    var _observersConfigured = false
    
    
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        
        super.init()
    }
    
    
    
    func registerForKeyboardNotifications() {
        if (!self._observersConfigured) {
            let center = NotificationCenter.default
            
            center.addObserver(self,
                               selector: #selector(CKKeyboardScroller.keyboardWasShown(_:)),
                               name: NSNotification.Name.UIKeyboardDidShow,
                               object: nil)
            
            center.addObserver(self,
                               selector: #selector(CKKeyboardScroller.keyboardWillHide(_:)),
                               name: NSNotification.Name.UIKeyboardWillHide,
                               object: nil)

            self._observersConfigured = true
        }
    }
    
    
    
    func removeKeyboardNotifications() {
        let center = NotificationCenter.default

        center.removeObserver(self,
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil)

        center.removeObserver(self,
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
        
        self.removeScrollViewContentInset()
        
        // print("removeKeyboardNotifications")
    }
    
    
    
    func keyboardWasShown(_ notification: Notification) {
        // print("keyboardWasShown")

        if (!self.keyboardIsShown) {
            var userInfo = (notification as NSNotification).userInfo!
            let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            
            self.scrollViewPreviousContentInset = self.scrollView.contentInset
            
            var contentInset = self.scrollView.contentInset
            contentInset.bottom += keyboardSize.height
            
            self.scrollView.contentInset = contentInset
            
            self.keyboardIsShown = true
            self.keyboardSize = keyboardSize
        }
    }

    
    func keyboardWillHide(_ notification: Notification) {
        // print("keyboardWillHide")

        self.keyboardIsShown = false
        self.keyboardSize = nil
        
        self.removeScrollViewContentInset()
    }
    
    
    
    func removeScrollViewContentInset() {
        // print("removeScrollViewContentInset")
        
        var contentInset: UIEdgeInsets?

        if (self.defaultScrollViewContentInset != nil) {
            contentInset = self.defaultScrollViewContentInset!
        }
        
        else if (self.scrollViewPreviousContentInset != nil) {
            contentInset = self.scrollViewPreviousContentInset!
        }

        self.scrollViewPreviousContentInset = nil
        
        // if a content inset was specified
        if (contentInset != nil) {
            let contentOffset = self.scrollView.contentOffset
            let animationDuration = 0.2
            
            UIView.animate(withDuration: animationDuration, animations: { 
                self.scrollView.contentOffset = contentOffset
                self.scrollView.contentInset = contentInset!
            })
        }
    }
    
    
    func scrollToViewOfInterest() {
        // print("scrollToViewOfInterest() TBD")
    }

}
