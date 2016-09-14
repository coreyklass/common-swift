//
//  CNLabeledValue+CKFriendlyLabels.swift
//  BlackBook
//
//  Created by Corey Klass on 6/14/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import Contacts


extension CNLabeledValue {
    
    static var friendlyLabelDict: [String: String] {
        get {
            let friendlyLabelDict: [String: String] = [
                CNLabelHome: "home",
                CNLabelWork: "work",
                CNLabelOther: "other",
                CNLabelEmailiCloud: "iCloud",
                CNLabelURLAddressHomePage: "url",
                CNLabelDateAnniversary: "anniversary",
                
                CNLabelPhoneNumberiPhone: "iPhone",
                CNLabelPhoneNumberMobile: "mobile",
                CNLabelPhoneNumberMain: "main",
                CNLabelPhoneNumberHomeFax: "home fax",
                CNLabelPhoneNumberWorkFax: "work fax",
                CNLabelPhoneNumberOtherFax: "other fax",
                CNLabelPhoneNumberPager: "pager"
            ]
            
            return friendlyLabelDict
        }
    }
    

    var friendlyLabel: String {
        get {
            /*
            let friendlyLabel = CNLabeledValue.friendlyLabelDict[self.label!] ?? self.label
            return friendlyLabel!
            */
            return "test"
        }
    }
    
}



