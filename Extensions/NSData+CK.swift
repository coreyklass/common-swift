//
//  NSData+CK.swift
//  BlackBook
//
//  Created by Corey Klass on 8/16/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension Data {
    
    // returns a string with the specified encoding
    func stringWithEncoding(_ encoding: String.Encoding) -> String? {
        let text = String(data: self, encoding: encoding)
        return text
    }
    
}
