//
//  CNContact+CK.swift
//  BlackBook
//
//  Created by Corey Klass on 7/23/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import Contacts



extension CNContact {

    func postalAddressLabeledValueByIdentifier(identifier: String) -> CNLabeledValue<CNPostalAddress>? {
        var labeledValue: CNLabeledValue<CNPostalAddress>?
        
        self.postalAddresses.forEach { (testValue: CNLabeledValue<CNPostalAddress>) in
            if (testValue.identifier == identifier) {
                labeledValue = testValue
            }
        }
        
        return labeledValue
    }
    
    
    func phoneLabeledValueByIdentifier(identifier: String) -> CNLabeledValue<CNPhoneNumber>? {
        var labeledValue: CNLabeledValue<CNPhoneNumber>?
        
        self.phoneNumbers.forEach { (testValue: CNLabeledValue<CNPhoneNumber>) in
            if (testValue.identifier == identifier) {
                labeledValue = testValue
            }
        }
        
        return labeledValue
    }

    
    func emailLabeledValueByIdentifier(identifier: String) -> CNLabeledValue<NSString>? {
        var labeledValue: CNLabeledValue<NSString>?
        
        self.emailAddresses.forEach { (testValue: CNLabeledValue<NSString>) in
            if (testValue.identifier == identifier) {
                labeledValue = testValue
            }
        }
        
        return labeledValue
    }

    
    
    func urlLabeledValueByIdentifier(identifier: String) -> CNLabeledValue<NSString>? {
        var labeledValue: CNLabeledValue<NSString>?
        
        self.urlAddresses.forEach { (testValue: CNLabeledValue<NSString>) in
            if (testValue.identifier == identifier) {
                labeledValue = testValue
            }
        }
        
        return labeledValue
    }

    
    
    

}









