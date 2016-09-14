//
//  CKAppVersion.swift
//  ORHP-Toolbox
//
//  Created by Corey Klass on 9/5/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit

class CKAppVersion: NSObject {
    
    // major version
    fileprivate var _majorVersion: Int?
    
    var majorVersion: Int { get { return self._majorVersion! } }
    
    
    // minor version
    fileprivate var _minorVersion: Int?
    
    var minorVersion: Int { get { return self._minorVersion! } }
    
    
    // patch version
    fileprivate var _patchVersion: Int?
    
    var patchVersion: Int { get { return self._patchVersion! } }
    
    
    // build number 
    fileprivate var _buildNumber: Int?
    
    var buildNumber: Int { get { return self._buildNumber! } }
    
    
    // text version
    fileprivate var _textVersion: String?
    
    var textVersion: String { get { return self._textVersion! } }
    
    
    
    
    // constructor
    override init() {
        super.init()
        
        self.parseAppVersion()
    }
    
    
    
    fileprivate func parseAppVersion() {
        // version number
        let versionText = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String) ?? ""
        
        let versionArray = versionText.components(separatedBy: ".")
        
        var majorVersion: Int = 0
        var minorVersion: Int = 0
        var patchVersion: Int = 0
        
        if (versionArray.count == 3) {
            majorVersion = Int(versionArray[0]) ?? 0
            minorVersion = Int(versionArray[1]) ?? 0
            patchVersion = Int(versionArray[2]) ?? 0
        }
            
        else if (versionArray.count == 2) {
            majorVersion = Int(versionArray[0]) ?? 0
            minorVersion = Int(versionArray[1]) ?? 0
        }
        
        // build number
        let buildNumberText = (Bundle.main.infoDictionary!["CFBundleVersion"] as? String) ?? ""
        let buildNumber = Int(buildNumberText) ?? 0
        
        // text version
        let textVersion = versionText + " (" + buildNumberText + ")"
        
        self._majorVersion = majorVersion
        self._minorVersion = minorVersion
        self._patchVersion = patchVersion
        self._buildNumber = buildNumber
        self._textVersion = textVersion
    }
    
    

}
