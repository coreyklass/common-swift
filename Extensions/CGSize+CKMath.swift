//
//  CGSize+CKMath.swift
//  BlackBook
//
//  Created by Corey Klass on 4/13/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit



extension CGSize {
    
    
    // returns a CGSize with the width and height multiplied by the specified value
    func sizeWithMultiplier(_ multiplier: CGFloat) -> CGSize {
        let newWidth = self.width * multiplier
        let newHeight = self.height * multiplier
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        return newSize
    }
    
    
}


