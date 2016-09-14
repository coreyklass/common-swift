//
//  CKViewBorder.swift
//  MathTester2
//
//  Created by Corey Klass on 6/8/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


extension UIView {

    func addBorder(_ color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }


    func setBorderRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }

    
}


