//
//  String+CKTextManipulation.swift
//  MalcontentBoffin
//
//  Created by Corey Klass on 7/1/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import Foundation


extension String {

    // returns a character at the index
    func characterAtIndex(i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }

    
    // returns a substring at the index
    func substringAtIndex(i: Int) -> String {
        return String(self.characterAtIndex(i: i))
    }
    
    
    // returns a substring for the range
    func substringFromIndex(fromIndex: Int, toIndex: Int) -> String {
        let start = characters.index(self.startIndex, offsetBy: fromIndex)
        let end = characters.index(self.startIndex, offsetBy: toIndex)
        
        return self[start...end]
    }
    
    
    // returns a substring for the range
    func substringFromIndex(fromIndex: Int, characterCount: Int) -> String {
        let start = characters.index(self.startIndex, offsetBy: fromIndex)
        let end = characters.index(self.startIndex, offsetBy: (fromIndex + characterCount - 1))
        
        return self[start...end]
    }
    
    
    
    
    
/*
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        let start = characters.index(self.startIndex, offsetBy: r.lowerBound)
        let end = characters.index(self.startIndex, offsetBy: r.upperBound)
        
        return self[start...end]
    }

    subscript (r: CountableRange<Int>) -> String {
        let start = characters.index(self.startIndex, offsetBy: r.lowerBound)
        let end = characters.index(self.startIndex, offsetBy: r.upperBound)
        
        return self[start..<end]
    }

*/
    
    func stringByReplacingCharactersFromPosition(_ startPosition: Int, endPosition: Int, withString string: String) -> String{
        let start = self.index(self.startIndex, offsetBy: startPosition)
        let end = self.index(self.startIndex, offsetBy: (endPosition+1))
        
        let range: Range<String.Index> = start..<end

        let string = self.replacingCharacters(in: range, with: string)
        
        return string
    }

    
    // removes all non-numeric characters
    func stripNonNumeric() -> String {
        var numericString = ""
        
        for charIndex in 0..<self.characters.count {
            let oneChar: String = self.substringAtIndex(i: charIndex)
            let oneInt = Int(oneChar)
            
            if (oneInt != nil) {
                numericString += oneChar
            }
        }
        
        return numericString
    }
    
    
    // formats a phone number
    func phoneFormat() -> String {
        var numericString = self.stripNonNumeric()
        var formattedString = ""
        
        if (numericString.characters.count == 11) {
            formattedString = numericString.substringFromIndex(fromIndex: 0, characterCount: 1) + " " +
                              "(" + numericString.substringFromIndex(fromIndex: 1, characterCount: 3) + ") " +
                              numericString.substringFromIndex(fromIndex: 4, characterCount: 3) + "-" +
                              numericString.substringFromIndex(fromIndex: 7, characterCount: 4)
        }
        else if (numericString.characters.count == 10) {
            formattedString = "(" + numericString.substringFromIndex(fromIndex: 0, characterCount: 3) + ") " +
                              numericString.substringFromIndex(fromIndex: 3, characterCount: 3) + "-" +
                              numericString.substringFromIndex(fromIndex: 6, characterCount: 4)
        }
        else if (numericString.characters.count == 7) {
            formattedString = numericString.substringFromIndex(fromIndex: 0, characterCount: 3) + "-" +
                              numericString.substringFromIndex(fromIndex: 3, characterCount: 4)
        }
        else {
            formattedString = self
        }
        
        return formattedString
    }
    
    
    
    // returns another string depending on a condition
    func ifEqualTo(_ compareText: String, replaceWith replaceText: String) -> String {
        var text = self
        
        if (text == compareText) {
            text = replaceText
        }
        
        return text
    }
    
    
}

