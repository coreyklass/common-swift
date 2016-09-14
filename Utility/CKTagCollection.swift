//
//  CKTagCollection.swift
//  MathTester2
//
//  Created by Corey Klass on 8/17/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation


class CKTagCollection : NSObject {

    
    
    var currentTag : Int = 0
    var tagCollection = [Int: AnyObject]()
    
    
    required override init() {
        
    }
    
    
    // returns the object for a given tag, or nil if not found
    func objectForTag(_ tag: Int) -> AnyObject? {
        var tagObject : AnyObject?
        
        if ((tag > 0) && (tag <= self.tagCollection.count)) {
            tagObject = self.tagCollection[tag]
        }

        return tagObject
    }
    
    
    
    // returns the tag for a given object
    func tagForObject(_ object: AnyObject) -> Int {
        var tag : Int = 0
        
        // look for the object in the collection
        for (tagIndexKey, tagIndexObject) in self.tagCollection {
            if (object.isEqual(tagIndexObject)) {
                tag = tagIndexKey
                break
            }
        }
        
        // if the object wasn't found
        if (tag == 0) {
            self.currentTag += 1
            
            self.tagCollection.updateValue(object, forKey: self.currentTag)

            tag = self.currentTag
        }

        return tag
    }
    
    
}





