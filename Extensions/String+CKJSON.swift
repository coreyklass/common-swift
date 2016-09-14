//
//  String+CKJSON.swift
//  ORHP-Toolbox
//
//  Created by Corey Klass on 9/11/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation



extension String {
    
    
    // parses the current string and turns it into a JSON object
    func parseJson() -> AnyObject? {
        var jsonPacket: AnyObject?
        var errorText: String?

        // convert the string to data
        let data = self.data(using: .utf8)
        
        // if data was passed in, try parsing it
        if (data != nil) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
                jsonPacket = (jsonObject as AnyObject)
            }
            catch let error as NSError {
                errorText = error.localizedDescription
            }
        }
        else {
            errorText = "JSON data empty"
        }
        
        if (errorText != nil) {
            print("** Error parsing JSON: " + errorText!)
        }
        
        return jsonPacket
    }
    
}


