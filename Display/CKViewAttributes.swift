//
//  CKViewAttributes.swift
//  BlackBook
//
//  Created by Corey Klass on 2/22/15.
//  Copyright (c) 2015 Corey Klass. All rights reserved.
//

import UIKit


class CKViewAttributes: NSObject {

    
    
    class func attributeCollection(_ font: UIFont?, color: UIColor?, backgroundColor: UIColor?) -> NSDictionary {
        let attributeDict = NSMutableDictionary()
        
        // if a font was specified
        if (font != nil) {
            attributeDict.setObject(font!, forKey: NSFontAttributeName as NSCopying)
        }
        
        // if a color was specified
        if (color != nil) {
            attributeDict.setObject(color!, forKey: NSForegroundColorAttributeName as NSCopying)
        }
        
        // if a background color was specified
        if (backgroundColor != nil) {
            attributeDict.setObject(backgroundColor!, forKey: NSBackgroundColorAttributeName as NSCopying)
        }
        
        return attributeDict
    }
    
    
    
}
