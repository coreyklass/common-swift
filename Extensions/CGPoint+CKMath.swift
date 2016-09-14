//
//  CGPoint+CKMath.swift
//  BlackBook
//
//  Created by Corey Klass on 4/13/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension CGPoint {
    
    // returns a CGPoint with the x and y multiplied by the specified value
    func pointWithMultiplier(_ multiplier: CGFloat) -> CGPoint {
        let newX = self.x * multiplier
        let newY = self.y * multiplier
        
        let newPoint = CGPoint(x: newX, y: newY)
        return newPoint
    }
    
    
}
