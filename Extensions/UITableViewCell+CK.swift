//
//  UITableViewCell+CK.swift
//  BlackBook
//
//  Created by Corey Klass on 6/8/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension UITableViewCell {
    
    // sets and returns the selected background color
    var selectedBackgroundColor: UIColor? {
        get {
            let color = self.selectedBackgroundView?.backgroundColor
            return color
        }
        set {
            let view = UIView(frame: CGRect.zero)
            view.backgroundColor = newValue
            self.selectedBackgroundView = view
        }
    }
    
}

