//
//  NSURL+CK.swift
//  BlackBook
//
//  Created by Corey Klass on 8/16/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension URL {
    
    // returns an NSData object with the contents of the URL
    func dataWithContentsOfURL() -> Data? {
        let data = try? Data(contentsOf: self)
        return data
    }
    
    
    // returns a String with the contents of the URL
    func stringContentsOfURLWithEncoding(_ encoding: String.Encoding) -> String? {
        let data = self.dataWithContentsOfURL()
        let text = data?.stringWithEncoding(encoding)
        return text
    }
    
}


