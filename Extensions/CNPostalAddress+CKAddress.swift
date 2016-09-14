//
//  CNPostalAddress+CKAddress.swift
//  BlackBook
//
//  Created by Corey Klass on 6/15/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import Contacts


extension CNPostalAddress {
    

    fileprivate func streetAtIndex(_ index: Int) -> String? {
        let components = self.street.components(separatedBy: "\n")
        let text: String? = (index < components.count ? components[index] : nil)
        return text
    }

    
    var street1: String? { get { return self.streetAtIndex(0) } }
    var street2: String? { get { return self.streetAtIndex(1) } }
    var street3: String? { get { return self.streetAtIndex(2) } }
    
    
}


