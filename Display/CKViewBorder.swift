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


struct CKViewBorder {

    static func addBorder(_ view: UIView, color: UIColor, width: CGFloat) {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
    }


    static func setBorderRadius(_ view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }

    
}


