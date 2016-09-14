//
//  CKFileUtility.swift
//  BlackBook
//
//  Created by Corey Klass on 11/14/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import UIKit

class CKFileUtility: NSObject {
   
    
    class func documentsDirectoryURL() -> NSURL {
        let fileManager = FileManager.default
        
        let docPaths : NSArray = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask) as NSArray
        
        let docPathURL = (docPaths.object(at: 0) as! NSURL)
        
        return docPathURL
    }
    
    
}
