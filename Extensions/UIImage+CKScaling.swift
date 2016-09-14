//
//  UIImage+CKScaling.swift
//  BlackBook
//
//  Created by Corey Klass on 2/28/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {

    
    func scaleToMaxSize(_ maxSize: CGSize) -> UIImage {
        // get the scale values for the width and height
        let xScale = maxSize.width / self.size.width
        let yScale = maxSize.height / self.size.height
        
        // we'll need one of these scales, whichever fits
        let xScaleSize = CGSize(width: self.size.width * xScale, height: self.size.height * xScale)
        let yScaleSize = CGSize(width: self.size.width * yScale, height: self.size.height * yScale)
        
        var newSize: CGSize
        
        // if the x scale is too large, use the y scale
        if ((xScaleSize.width > maxSize.width) || (xScaleSize.height > maxSize.height)) {
            newSize = yScaleSize
        }
            
        // otherwise use the x scale
        else {
            newSize = xScaleSize
        }
        
        // resize and return the image
        let image = self.scaleToSize(newSize)
        
        return image
    }
    
    
    
    func scaleToSize(_ size: CGSize) -> UIImage {
        // Create a bitmap graphics context
        // This will also set it as the current context
        UIGraphicsBeginImageContext(size)
        
        // Draw the scaled image in the current context
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        // Create a new image from current context
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Pop the current context from the stack
        UIGraphicsEndImageContext()
        
        // Return our new scaled image
        return scaledImage!
    }
    
    
    
    
    // crops the image in the rectangle
    func croppedImageInRect(_ rect: CGRect) -> UIImage {

        func rad(_ deg: CGFloat) -> CGFloat {
            return deg / 180.0 * CGFloat(M_PI)
        }
        
        var rectTransform: CGAffineTransform
        
        if (self.imageOrientation == UIImageOrientation.left) {
            rectTransform = CGAffineTransform(rotationAngle: rad(90)).translatedBy(x: 0, y: -self.size.height)
        }
        
        else if (self.imageOrientation == UIImageOrientation.right) {
            rectTransform = CGAffineTransform(rotationAngle: rad(-90)).translatedBy(x: -self.size.width, y: 0)
        }
        
        else if (self.imageOrientation == UIImageOrientation.down) {
            rectTransform = CGAffineTransform(rotationAngle: rad(-180)).translatedBy(x: -self.size.width, y: -self.size.height)
        }
        
        else {
            rectTransform = CGAffineTransform.identity
        }
        
        rectTransform = rectTransform.scaledBy(x: self.scale, y: self.scale)
        
        let imageRef: CGImage = self.cgImage!.cropping(to: rect.applying(rectTransform))!
        let imageResult = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return imageResult
    }
    
    
    


}











