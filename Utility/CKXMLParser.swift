//
//  CKXMLParser.swift
//  Watchboard
//
//  Created by Corey Klass on 9/23/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit

class CKXMLParser: NSObject {

    var xmlText: String

    fileprivate var _xmlRootElement: CKXMLElement?
    fileprivate var _xmlCurrentElement: CKXMLElement?
    
    // constructor
    init(xmlText: String) {
        self.xmlText = xmlText
        
        super.init()
    }
    
    
    
    // parses the text
    func parse() -> [String: Any]? {
        let data = self.xmlText.data(using: .utf8)
        let parser = XMLParser(data: data!)
        parser.delegate = self
        
        self._xmlRootElement = CKXMLElement(elementName: "root")
        
        self._xmlCurrentElement = self._xmlRootElement
        
        let success = parser.parse()

        var object: [String: Any]?
        
        if (success) {
            // now that it's parsed, build an object
            object = self.objectFromXMLElement(xmlElement: self._xmlCurrentElement!)
        }
        
        return object
    }

    
    
    fileprivate func objectFromXMLElement(xmlElement: CKXMLElement) -> [String: Any] {
        var object = [String: Any]()
        
        object["xmlElementName"] = xmlElement.elementName
        object["xmlText"] = xmlElement.xmlText
        object["xmlAttributes"] = xmlElement.xmlAttributes
        object["xmlChildren"] = [String: Any]()
        
        xmlElement.xmlChildren.keys.forEach { (key: String) in
            let xmlChildObject = xmlElement.xmlChildren[key]
            
            if let xmlChildArray = (xmlChildObject as? [CKXMLElement]) {
                var childObjects = [Any]()
                
                xmlChildArray.forEach({ (xmlChildElement: CKXMLElement) in
                    let childObject = self.objectFromXMLElement(xmlElement: xmlChildElement)
                    childObjects.append(childObject)
                })
                
                if var xmlChildren = (object["xmlChildren"] as? [String: Any]) {
                    xmlChildren[key] = childObjects
                    object["xmlChildren"] = xmlChildren
                }
            }
            
            else if let xmlChildElement = (xmlChildObject as? CKXMLElement) {
                let childObject = self.objectFromXMLElement(xmlElement: xmlChildElement)

                if var xmlChildren = (object["xmlChildren"] as? [String: Any]) {
                    xmlChildren[key] = childObject
                    object["xmlChildren"] = xmlChildren
                }
            }
        }
        
        return object
    }
    
    
}



fileprivate class CKXMLElement: NSObject {
    
    var elementName: String
    var xmlParent: CKXMLElement?
    var xmlChildren = [String: Any]()
    var xmlText = ""
    var xmlAttributes: [String: Any]?

    
    // constructor
    init(elementName: String) {
        self.elementName = elementName
        
        super.init()
    }
    
}







extension CKXMLParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {

        // test to see if we convert a dict to an array
        if let xmlTestChildElement = (self._xmlCurrentElement!.xmlChildren[elementName] as? CKXMLElement) {
            let xmlChildElements = [xmlTestChildElement]
            self._xmlCurrentElement!.xmlChildren[elementName] = xmlChildElements
        }
        
        
        // create some new child objects
        let xmlElement = CKXMLElement(elementName: elementName)
        xmlElement.xmlParent = self._xmlCurrentElement
        xmlElement.xmlAttributes = attributeDict
        
        
        // if this is an array
        if var xmlArray = (self._xmlCurrentElement!.xmlChildren[elementName] as? [CKXMLElement]) {
            xmlArray.append(xmlElement)
            
            self._xmlCurrentElement!.xmlChildren[elementName] = xmlArray
        }
        
        // if this isn't an array
        else {
            self._xmlCurrentElement!.xmlChildren[elementName] = xmlElement
        }

        
        self._xmlCurrentElement = xmlElement
    }
    
    
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {

        self._xmlCurrentElement = self._xmlCurrentElement!.xmlParent
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self._xmlCurrentElement?.xmlText = (self._xmlCurrentElement?.xmlText ?? "") + string
    }
    
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML Parse Error Occurred:")
        print(parseError.localizedDescription)
    }
    
    
}






