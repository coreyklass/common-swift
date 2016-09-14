
//
//  CKAddressBook.swift
//  BlackBook
//
//  Created by Corey Klass on 12/31/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import UIKit
import AddressBookUI


class CKAddressBook: NSObject {

    // var internalAddressBook : ABAddressBook?
    

    /*
    
    override init() {
        var err : Unmanaged<CFError>? = nil
        let ab = ABAddressBookCreateWithOptions(nil, &err)
        
        if (err == nil) {
            self.internalAddressBook = ab.takeRetainedValue()
            println("ABAddressBook Initialization Successful")
        }
        
        else {
            println("ABAddressBook Initialization FAILURE")
        }
    }
    

    class func authorizationStatus() -> ABAuthorizationStatus {
        return ABAddressBookGetAuthorizationStatus()
    }
    
    
    func requestAccessWithCompletion( completion : (Bool, CFError?) -> Void ) {
        ABAddressBookRequestAccessWithCompletion(internalAddressBook) {(let b : Bool, c : CFError!) -> Void in completion(b,c)}
    }

    
    /*
    
    
    func hasUnsavedChanges() -> Bool {
        return ABAddressBookHasUnsavedChanges(internalAddressBook)
    }
    
    func save() -> CFError? {
        return errorIfNoSuccess { ABAddressBookSave(self.internalAddressBook, $0)}
    }
    
    func revert() {
        ABAddressBookRevert(internalAddressBook)
    }
    
    func addRecord(record : SwiftAddressBookRecord) -> CFError? {
        return errorIfNoSuccess { ABAddressBookAddRecord(self.internalAddressBook, record.internalRecord, $0) }
    }
    
    func removeRecord(record : SwiftAddressBookRecord) -> CFError? {
        return errorIfNoSuccess { ABAddressBookRemoveRecord(self.internalAddressBook, record.internalRecord, $0) }
    }

    */


    
    class func friendlyLabelForSystemLabel(systemLabel: String) -> String {
        var friendlyLabel = systemLabel

        var systemLabelString = (systemLabel as NSString)
        
        if (systemLabelString == kABHomeLabel) {
            friendlyLabel = "home"
        }
        else if (systemLabelString == kABOtherLabel) {
            friendlyLabel = "other"
        }
        else if (systemLabelString == kABPersonAddressCityKey) {
            friendlyLabel = "city"
        }
        else if (systemLabelString == kABPersonAddressStateKey) {
            friendlyLabel = "state"
        }
        else if (systemLabelString == kABPersonAddressStreetKey) {
            friendlyLabel = "street"
        }
        else if (systemLabelString == kABPersonAddressZIPKey) {
            friendlyLabel = "zip"
        }
        else if (systemLabelString == kABPersonInstantMessageServiceAIM) {
            friendlyLabel = "aim"
        }
        else if (systemLabelString == kABPersonInstantMessageServiceFacebook) {
            friendlyLabel = "facebook"
        }
        else if (systemLabelString == kABPersonInstantMessageServiceGoogleTalk) {
            friendlyLabel = "google talk"
        }
        else if (systemLabelString == kABPersonInstantMessageServiceSkype) {
            friendlyLabel = "skype"
        }
        else if (systemLabelString == kABPersonInstantMessageServiceYahoo) {
            friendlyLabel = "yahoo"
        }
        else if (systemLabelString == kABPersonPhoneHomeFAXLabel) {
            friendlyLabel = "home fax"
        }
        else if (systemLabelString == kABPersonPhoneIPhoneLabel) {
            friendlyLabel = "iPhone"
        }
        else if (systemLabelString == kABPersonPhoneMainLabel) {
            friendlyLabel = "main"
        }
        else if (systemLabelString == kABPersonPhoneMobileLabel) {
            friendlyLabel = "mobile"
        }
        else if (systemLabelString == kABPersonPhoneOtherFAXLabel) {
            friendlyLabel = "other fax"
        }
        else if (systemLabelString == kABPersonPhonePagerLabel) {
            friendlyLabel = "pager"
        }
        else if (systemLabelString == kABPersonPhoneWorkFAXLabel) {
            friendlyLabel = "work fax"
        }
        else if (systemLabelString == kABPersonSocialProfileServiceFacebook) {
            friendlyLabel = "facebook"
        }
        else if (systemLabelString == kABPersonSocialProfileServiceFlickr) {
            friendlyLabel = "flickr"
        }
        else if (systemLabelString == kABPersonSocialProfileServiceGameCenter) {
            friendlyLabel = "game center"
        }
        else if (systemLabelString == kABPersonSocialProfileServiceLinkedIn) {
            friendlyLabel = "linked in"
        }
        else if (systemLabelString == kABPersonSocialProfileServiceMyspace) {
            friendlyLabel = "myspace"
        }
        else if (systemLabelString == kABPersonSocialProfileServiceTwitter) {
            friendlyLabel = "twitter"
        }
        else if (systemLabelString == kABWorkLabel) {
            friendlyLabel = "work"
        }

        return friendlyLabel
    }
    
    
    class func systemLabelForFriendlyLabel(friendlyLabel: String) -> String {
        var systemLabelString = (friendlyLabel as NSString)
        
        var friendlyLabelClean = friendlyLabel.lowercaseString
        
        if (friendlyLabelClean == "home") {
            systemLabelString = kABHomeLabel
        }
        else if (friendlyLabelClean == "other") {
            systemLabelString = kABOtherLabel
        }
        else if (friendlyLabelClean == "city") {
            systemLabelString = kABPersonAddressCityKey
        }
        else if (friendlyLabelClean == "state") {
            systemLabelString = kABPersonAddressStateKey
        }
        else if (friendlyLabelClean == "street") {
            systemLabelString = kABPersonAddressStreetKey
        }
        else if (friendlyLabelClean == "zip") {
            systemLabelString = kABPersonAddressZIPKey
        }
        else if (friendlyLabelClean == "aim") {
            systemLabelString = kABPersonInstantMessageServiceAIM
        }
        else if (friendlyLabelClean == "facebook") {
            systemLabelString = kABPersonInstantMessageServiceFacebook
        }
        else if (friendlyLabelClean == "google talk") {
            systemLabelString = kABPersonInstantMessageServiceGoogleTalk
        }
        else if (friendlyLabelClean == "skype") {
            systemLabelString = kABPersonInstantMessageServiceSkype
        }
        else if (friendlyLabelClean == "yahoo") {
            systemLabelString = kABPersonInstantMessageServiceYahoo
        }
        else if (friendlyLabelClean == "home fax") {
            systemLabelString = kABPersonPhoneHomeFAXLabel
        }
        else if (friendlyLabelClean == "iPhone") {
            systemLabelString = kABPersonPhoneIPhoneLabel
        }
        else if (friendlyLabelClean == "main") {
            systemLabelString = kABPersonPhoneMainLabel
        }
        else if (friendlyLabelClean == "mobile") {
            systemLabelString = kABPersonPhoneMobileLabel
        }
        else if (friendlyLabelClean == "other fax") {
            systemLabelString = kABPersonPhoneOtherFAXLabel
        }
        else if (friendlyLabelClean == "pager") {
            systemLabelString = kABPersonPhonePagerLabel
        }
        else if (friendlyLabelClean == "work fax") {
            systemLabelString = kABPersonPhoneWorkFAXLabel
        }
        else if (friendlyLabelClean == "facebook") {
            systemLabelString = kABPersonSocialProfileServiceFacebook
        }
        else if (friendlyLabelClean == "flickr") {
            systemLabelString = kABPersonSocialProfileServiceFlickr
        }
        else if (friendlyLabelClean == "game center") {
            systemLabelString = kABPersonSocialProfileServiceGameCenter
        }
        else if (friendlyLabelClean == "linked in") {
            systemLabelString = kABPersonSocialProfileServiceLinkedIn
        }
        else if (friendlyLabelClean == "myspace") {
            systemLabelString = kABPersonSocialProfileServiceMyspace
        }
        else if (friendlyLabelClean == "twitter") {
            systemLabelString = kABPersonSocialProfileServiceTwitter
        }
        else if (friendlyLabelClean == "work") {
            systemLabelString = kABWorkLabel
        }
        
        var systemLabel = (systemLabelString as! String)

        return systemLabel
    }
    

}



// a generic address book record
class CKAddressBookRecord: NSObject {
    
    var internalRecord : ABRecord
    
    
    init(record: ABRecord) {
        self.internalRecord = record
        
        super.init()
    }
    
    
    func recordID() -> ABRecordID {
        return ABRecordGetRecordID(self.internalRecord)
    }
    
}




// a person address book record
class CKAddressBookPerson: CKAddressBookRecord {
    

    var firstName : String {
        get {
            var text = ABRecordCopyValue(self.internalRecord, kABPersonFirstNameProperty)?.takeRetainedValue() as! String?
            return (text != nil ? text! : "")
        }
    }

    var lastName : String {
        get {
            var text = ABRecordCopyValue(self.internalRecord, kABPersonLastNameProperty)?.takeRetainedValue() as! String?
            return (text != nil ? text! : "")
        }
    }

    var birthday : NSDate? {
        get {
            var date = ABRecordCopyValue(self.internalRecord, kABPersonBirthdayProperty)?.takeRetainedValue() as! NSDate?
            return date
        }
    }
    
    
    var image : UIImage? {
        get {
            var image : UIImage?
            var imageData = ABPersonCopyImageData(self.internalRecord)?.takeRetainedValue() as NSData?
            
            if (imageData != nil) {
                image = UIImage(data: imageData!)
            }

            return image
        }
    }
    
    
    var phoneNumbers : [CKAddressBookPhoneNumber] {
        get {
            var phoneNumbers = [CKAddressBookPhoneNumber]()
            
            var abPhoneNumbers : ABMultiValue? = ABRecordCopyValue(self.internalRecord, kABPersonPhoneProperty)?.takeRetainedValue()
            
            var phoneNumberCount = ABMultiValueGetCount(abPhoneNumbers)
            
            for (var phoneNumberIndex=0; phoneNumberIndex < phoneNumberCount; phoneNumberIndex++) {
                
                var labelString : NSString = ABMultiValueCopyLabelAtIndex(abPhoneNumbers, phoneNumberIndex).takeRetainedValue()
                var label : String = (labelString as! String)
                
                var valueString : NSString = ABMultiValueCopyValueAtIndex(abPhoneNumbers, phoneNumberIndex).takeRetainedValue() as! NSString
                var value : String = (valueString as! String)
                
                var id = Int(ABMultiValueGetIdentifierAtIndex(abPhoneNumbers, phoneNumberIndex))
                
                var phoneNumber = CKAddressBookPhoneNumber(id: id, systemLabel: label, value: value)
                phoneNumbers.append(phoneNumber)
            }
            
            return phoneNumbers
        }
    }
    
    
    override init(record: ABRecord) {
        super.init(record: record)

        var logText = "ABAddressBook record loaded: " + self.firstName
        logText +=  " / " + self.lastName
        logText += " / " + self.recordID().description
        
        if (self.birthday != nil) {
            logText += " / " + self.birthday!.description
        }
        
        println(logText)
    }
    
*/
    
    
}






class CKAddressBookPhoneNumber : NSObject {
    
    var id : Int
    var systemLabel : String
    var value : String
    
    
    init(id: Int, systemLabel: String, value: String) {
        self.id = id
        self.systemLabel = systemLabel
        self.value = value
        
        super.init()
    }
    
    
    func friendlyLabel() -> String {
        // return CKAddressBook.friendlyLabelForSystemLabel(self.systemLabel)
        return ""
    }
    
    
    func phoneDescription() -> String {
        let text = self.friendlyLabel() + ": " + self.value
        return text
    }
    
    
    
    
    
    
    
    
}




