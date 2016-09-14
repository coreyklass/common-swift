//
//  String+CKHashing.swift
//  BlackBook
//
//  Created by Corey Klass on 8/20/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

// REQUIRES OBJECTIVE-C BRIDGING FILE W/:
// #import <CommonCrypto/CommonCrypto.h>



import Foundation


extension String {

    // hashing function
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        
        CC_SHA1((data as NSData).bytes, CC_LONG(data.count), &digest)
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        
        return hexBytes.joined(separator: "")
    }
    

/*
 // Swift 3:
     

    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined(separator: "")
    }
*/
    
    

}

