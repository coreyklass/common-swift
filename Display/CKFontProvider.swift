//
//  CKFontProvider.swift
//  BlackBook
//
//  Created by Corey Klass on 12/30/15.
//  Copyright © 2015 Corey Klass. All rights reserved.
//

import UIKit

class CKFontProvider: NSObject {
    
    
    // what the size adder is
    var sizeAdder: CGFloat = 2
    
    
    
    override init() {
        super.init()
    }
    
    
    // init with a size adder
    init(sizeAdder: CGFloat) {
        super.init()
        
        self.sizeAdder = sizeAdder
    }
    
    
    

    // returns a font reference
    func fontWithSize(_ size: CKFontProviderSize) -> UIFont {
        return self.fontWithSize(size, style: CKFontProviderStyle.normal)
    }
    
    
    func boldFontWithSize(_ size: CKFontProviderSize) -> UIFont {
        return self.fontWithSize(size, style: CKFontProviderStyle.bold)
    }
    
    
    
    // returns a font reference
    func fontWithSize(_ size: CKFontProviderSize, style: CKFontProviderStyle) -> UIFont {
        
        // here's the base system font
        let systemFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        // what's the size of the system font, with any adder
        let baseFontSize: CGFloat = (systemFont.lineHeight + self.sizeAdder)

        var fontSize = baseFontSize
        
        if (size == .xxSmall) {
            fontSize -= 8
        }
        else if (size == .xSmall) {
            fontSize -= 4
        }
        else if (size == .small) {
            fontSize -= 2
        }
        else if (size == .large) {
            fontSize += 2
        }
        else if (size == .xLarge) {
            fontSize += 4
        }
        else if (size == .xxLarge) {
            fontSize += 8
        }
        
        
        var font: UIFont
        
        if (style == .bold) {
            font = UIFont.boldSystemFont(ofSize: fontSize)
        }
        else {
            font = UIFont.systemFont(ofSize: fontSize)
        }
        
        return font
    }
    
    
    
}



enum CKFontProviderSize: Int {
    case xxSmall = 1010
    case xSmall = 1020
    case small = 1030
    case normal = 1040
    case large = 1050
    case xLarge = 1060
    case xxLarge = 1070
}


enum CKFontProviderStyle: Int {
    case normal = 2010
    case bold = 2020
}
