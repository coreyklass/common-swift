//
//  CKKeychainItem.swift
//  BlackBook
//
//  Created by Corey Klass on 8/18/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import Security



class CKKeychainItem: NSObject {
    
    /*
     
     These are the default constants and their respective types,
     available for the kSecClassGenericPassword Keychain Item class:
     
     kSecAttrAccessGroup         -       CFStringRef
     kSecAttrCreationDate        -       CFDateRef
     kSecAttrModificationDate    -       CFDateRef
     kSecAttrDescription         -       CFStringRef
     kSecAttrComment             -       CFStringRef
     kSecAttrCreator             -       CFNumberRef
     kSecAttrType                -       CFNumberRef
     kSecAttrLabel               -       CFStringRef
     kSecAttrIsInvisible         -       CFBooleanRef
     kSecAttrIsNegative          -       CFBooleanRef
     kSecAttrAccount             -       CFStringRef
     kSecAttrService             -       CFStringRef
     kSecAttrGeneric             -       CFDataRef
     
     See the header file Security/SecItem.h for more details.
     
     */

    // identifier
    fileprivate var _identifier = ""
    
    var identifier: String {
        get {
            return self._identifier
        }
    }
    
    
    // service
    fileprivate var _service = ""
    
    var service: String {
        get {
            return self._service
        }
    }
    
    
    // access group
    fileprivate var _accessGroup: String?
    
    var accessGroup: String? {
        get {
            return self._accessGroup
        }
    }
    
    
    // keychain value
    fileprivate var _keychainValue: String?
    
    var keychainValue: String? {
        get {
            return self._keychainValue
        }
        set {
            if (self._keychainValue != newValue) {
                self._keychainValue = newValue
                self.persistKeychainValue()
            }
        }
    }
    
    
    // log function
    var loggingHandler: ((_ logText: String) -> Void)?
    
    
    
    
    // constructor
    init(identifier: String, service: String, accessGroup: String?) {
        self._identifier = identifier
        self._service = service
        self._accessGroup = accessGroup
        
        super.init()
        
        let keychainValueData = self.loadKeychainValueData()
        
        if (keychainValueData != nil) {
            self._keychainValue = String(data: keychainValueData!, encoding: String.Encoding.utf8) ?? ""
        }
    }
    
    
    fileprivate func appendLog(_ logText: String) {
        // if a logging handler was specified
        if (self.loggingHandler != nil) {
            self.loggingHandler!(logText)
        }
        
        // no logging handler, just print the text
        else {
            print(logText)
        }
    }
    
    
    
    fileprivate func newSearchDictionary() -> NSMutableDictionary {
        let dictionary = NSMutableDictionary()
        
        dictionary.setObject(kSecClassGenericPassword, forKey: (kSecClass as String as String as NSCopying))

        let encodedIdentifier = self.identifier.data(using: String.Encoding.utf8)
        dictionary.setObject(encodedIdentifier!, forKey: (kSecAttrGeneric as String as String as NSCopying))
        dictionary.setObject(encodedIdentifier!, forKey: (kSecAttrAccount as String as String as NSCopying))

        dictionary.setObject(self.service, forKey: (kSecAttrService as String as String as NSCopying))
        
        if (self.accessGroup != nil) {
            dictionary.setObject(self.accessGroup!, forKey: (kSecAttrAccessGroup as String as String as NSCopying))
        }
        
        return dictionary
    }
    
    
    
    fileprivate func loadKeychainValueData() -> Data? {
        let searchDictionary = self.newSearchDictionary()
        
        // add search attributes
        searchDictionary.setObject(kSecMatchLimitOne, forKey: (kSecMatchLimit as String as String as NSCopying))
        
        // Tell the search to only return the data
        searchDictionary.setObject(kCFBooleanTrue, forKey: (kSecReturnData as String as String as NSCopying))

        // where are we storing the result
        var result: Data?

        var dataTypeRef: AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(searchDictionary, &dataTypeRef)
        
        let logText = "Keychain status: " + String(status)
        print(logText)
        
        if (status == errSecSuccess) {
            if let retrievedDictData = dataTypeRef {
                result = retrievedDictData as? Data
            }
        }
        
        /*
        _ = withUnsafeMutablePointer(to: &result) {
            $0.withMemoryRebound(to: CFTypeRef.self, capacity: 1, {
                SecItemCopyMatching(searchDictionary, $0)
            })
        }
        */
        
        /*
        _ = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(searchDictionary, UnsafeMutablePointer($0))
        }
        */
        
        return result
    }
    


    
    

    fileprivate func persistKeychainValue() {
        var status: OSStatus?
        var logText: String?
        
        // look for the existing value
        let savedKeychainValueData = self.loadKeychainValueData()
        
        // if it was found
        if (savedKeychainValueData != nil) {

            let searchDictionary = self.newSearchDictionary()

            // update action
            if (self.keychainValue != nil) {
                let updateDictionary = NSMutableDictionary()
                
                let keychainValueData = self.keychainValue!.data(using: String.Encoding.utf8)
                updateDictionary.setObject(keychainValueData!, forKey: (kSecValueData as String as String as NSCopying))
                
                status = SecItemUpdate(searchDictionary, updateDictionary)
                
                logText = self.identifier + ": SecItemUpdate() -> " + self.friendlySecErrorText(status)
            }
            
            // delete action
            else {
                status = SecItemDelete(searchDictionary)

                logText = self.identifier + ": SecItemDelete() -> " + self.friendlySecErrorText(status)
            }
        }
        
        // not found, so insert
        else if (self.keychainValue != nil) {
            let searchDictionary = self.newSearchDictionary()
            
            let keychainValueData = self.keychainValue!.data(using: String.Encoding.utf8)
            searchDictionary.setObject(keychainValueData!, forKey: (kSecValueData as String as String as NSCopying))
            
            status = SecItemAdd(searchDictionary, nil)

            logText = self.identifier + ": SecItemAdd() -> " + self.friendlySecErrorText(status)
        }
        
        // log the result
        if (logText != nil) {
            self.appendLog(logText!)
        }
        
    }
    
    
        
        
    
    fileprivate func friendlySecErrorText(_ status: OSStatus?) -> String {
        var friendlyText: String?
        let unwrappedStatus = status!
        
        switch (unwrappedStatus) {
            case errSecSuccess: friendlyText = "No error"
            case errSecUnimplemented: friendlyText = "Function or operation not implemented"
            case errSecParam: friendlyText = "One or more parameters passed to the function were not valid"
            case errSecAllocate: friendlyText = "Failed to allocate memory"
            case errSecNotAvailable: friendlyText = "No trust results are available"
            case errSecAuthFailed: friendlyText = "Authorization/Authentication failed"
            case errSecDuplicateItem: friendlyText = "The item already exists"
            case errSecItemNotFound: friendlyText = "The item cannot be found"
            case errSecInteractionNotAllowed: friendlyText = "Interaction with the Security Server is not allowed"
            case errSecDecode: friendlyText = "Unable to decode the provided data"
            default: friendlyText = "Unknown error"
        }
        
        let returnText = friendlyText! + " (" + String(unwrappedStatus) + ")"

        return returnText
    }
    
    
    
}





