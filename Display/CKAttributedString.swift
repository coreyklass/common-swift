//
//  CKAttributedString.swift
//  BlackBook
//
//  Created by Corey Klass on 12/25/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import UIKit

class CKAttributedString: NSObject {

    
    var lineSpacing : CGFloat = -1.0
    
    
    // inner class to hold sections
    class CKAttributedStringSection: NSObject {

        var text : String
        var font : UIFont?
        var color : UIColor?
        var backgroundColor: UIColor?
        
        
        init(text: String, font: UIFont?, color: UIColor?, backgroundColor: UIColor?) {
            self.text = text
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
            
            super.init()
        }
        
        
        // creates an attributes dictionary
        func attributeDictionary() -> NSMutableDictionary {
            let attributeDict = NSMutableDictionary()
            
            // if a font was specified
            if (self.font != nil) {
                attributeDict.setObject(self.font!, forKey: NSFontAttributeName as NSCopying)
            }
            
            // if a color was specified
            if (self.color != nil) {
                attributeDict.setObject(self.color!, forKey: NSForegroundColorAttributeName as NSCopying)
            }

            // if a background color was specified
            if (self.backgroundColor != nil) {
                attributeDict.setObject(self.backgroundColor!, forKey: NSBackgroundColorAttributeName as NSCopying)
            }

            return attributeDict
        }
        
    }
    
    
    // array to store attributed string sections
    var attributedStringSections = [CKAttributedStringSection]()
    
    
    // constructor
    override init() {
        super.init()
    }
    
    
    // appends text
    
    func appendText(_ text: String) {
        self.appendText(text, font: nil, color: nil, backgroundColor: nil)
    }

    
    func appendText(_ text: String, font: UIFont?) {
        self.appendText(text, font: font, color: nil, backgroundColor: nil)
    }
    
    
    func appendText(_ text: String, font: UIFont?, color: UIColor?) {
        self.appendText(text, font: font, color: color, backgroundColor: nil)
    }
    
        
    func appendText(_ text: String, font: UIFont?, color: UIColor?, backgroundColor: UIColor?) {
        let section = CKAttributedStringSection(text: text, font: font, color: color, backgroundColor: backgroundColor)
        self.attributedStringSections.append(section)
    }
    
    
    
    // generated an NSMutableAttributedString
    func makeAttributedString() -> NSMutableAttributedString {
        
        // build the full text
        var fullText = ""
        
        for sectionIndex in 0..<self.attributedStringSections.count {
            fullText += self.attributedStringSections[sectionIndex].text
        }
        
        // create an attributed string
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // keep a running position counter
        var stringPosition = 0

        // loop over the sections, adding formatting
        for sectionIndex in 0..<self.attributedStringSections.count {
            let section = self.attributedStringSections[sectionIndex]
            
            let stringLength = section.text.lengthOfBytes(using: String.Encoding.utf8) // count(section.text.utf16)
            let stringRange = NSMakeRange(stringPosition, stringLength)
            
            let attributeDictionary = section.attributeDictionary()
            
            var attributeCollection = [String: AnyObject]()
            
            for keyIndex in 0..<attributeDictionary.allKeys.count {
                let oneKey = (attributeDictionary.allKeys[keyIndex] as! String)
                let oneValue = attributeDictionary.object(forKey: oneKey)
                
                attributeCollection[oneKey] = oneValue as AnyObject?
            }
            
            attributedString.setAttributes(attributeCollection, range: stringRange)

            if (self.lineSpacing != -1) {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = self.lineSpacing
                
                attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            }
            
            
            stringPosition += stringRange.length
        }
        
        return attributedString
    }
    
    
    
}
