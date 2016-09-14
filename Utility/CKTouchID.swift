//
//  CKTouchID.swift
//  BlackBook
//
//  Created by Corey Klass on 8/22/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit
import LocalAuthentication

/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   In your Xcode project Linked Frameworks, add "LocalAuthentication.framework"
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */


class CKTouchID: NSObject {

    // constructor
    override init() {
        super.init()
    }

    
    var message: String = "Authentication Required"
    var successHandler: (() -> Void)?
    var errorHandler: ((_ errorType: CKTouchIDErrorType, _ error: NSError) -> Void)?
    
    
    // does the device support touch
    static func doesDeviceSupportTouch() -> Bool {
        let context = LAContext()
        var error: NSError?
        
        // does the device support TouchID?
        let supportsTouch = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        // if an error occurred
        if (error != nil) {
            print("Error checking for TouchID capability:")
            print(error!.localizedDescription)
        }
        
        return supportsTouch
    }
    
    
    // called to authenticate the user
    func promptForAuthentication() {
        let context = LAContext()
        
        var supportsTouchError: NSError?
        
        // does the device support TouchID?
        let supportsTouch = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &supportsTouchError)
        
        // if the device supports touch, prompt the user
        if (supportsTouch) {
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: self.message,
                reply: { (success: Bool, policyEvalError: Error?) in
                    let error = policyEvalError as? NSError
                    
                    // if the call was successful
                    if (success) {
                        self.authenticationDidSucceed()
                    }
                    // if the call failed
                    else {
                        self.authenticationDidFail(error!)
                    }
            })
            
        }
        
        // the device doesn't support touch
        else {
            self.authenticationDidFail(supportsTouchError!)
        }
    }

    
    // authentication succeeded
    func authenticationDidSucceed() {
        print("Authentication succeeded")
        
        // call the success handler
        DispatchQueue.main.async(execute: { () -> Void in
            self.successHandler?()
        })
    }
    
    
    // authentication failure
    func authenticationDidFail(_ error: NSError) {
        print("Authentication failed")
        
        var errorType: CKTouchIDErrorType
        
        // which error did we get?
        switch error.code {
            case LAError.Code.systemCancel.rawValue:
                errorType = .systemCancel
                break
            
            case LAError.Code.userCancel.rawValue:
                errorType = .userCancel
                break
            
            case LAError.Code.userFallback.rawValue:
                errorType = .userFallback
                break
            
            case LAError.Code.touchIDNotEnrolled.rawValue:
                errorType = .touchIDNotEnrolled
                break
                
            case LAError.Code.passcodeNotSet.rawValue:
                errorType = .passcodeNotSet
                break
            
            default:
                errorType = .unknownError
                break
        }
        
        print(errorType)
        
        // call the error handler
        DispatchQueue.main.async(execute: { () -> Void in
            self.errorHandler?(errorType, error)
        })
    }

    
    
}



enum CKTouchIDErrorType {
    // Authentication was cancelled by the system
    case systemCancel
    
    // Authentication was cancelled by the user
    case userCancel
    
    // User selected to enter custom password
    case userFallback
    
    // TouchID is not enrolled
    case touchIDNotEnrolled
    
    // Passcode is not set
    case passcodeNotSet
    
    // Other error
    case unknownError
}


