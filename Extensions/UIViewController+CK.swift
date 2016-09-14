//
//  UIViewController+CK.swift
//  BlackBook
//
//  Created by Corey Klass on 8/22/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController {
    
    // http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate
    func findShownViewController() -> UIViewController? {
        var viewController: UIViewController?
        
        // if this view controller has a presented view controller
        if (self.presentedViewController != nil) {
            viewController = self.presentedViewController!.findShownViewController()
        }
        
        // if this view controller is a split view
        else if let splitViewController = (self as? UISplitViewController) {
            viewController = splitViewController.viewControllers.last?.findShownViewController() ?? splitViewController
        }
     
        // if this is a navigation controller
        else if let navViewController = (self as? UINavigationController) {
            viewController = navViewController.topViewController ?? navViewController
        }
        
        // if this is a tab bar controller
        else if let tabBarController = (self as? UITabBarController) {
            viewController = tabBarController.selectedViewController?.findShownViewController() ?? tabBarController
        }
        
        // unknown, return self
        else {
            viewController = self
        }
        
        return viewController
    }
    
}

