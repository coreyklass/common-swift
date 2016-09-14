//
//  Dictionary+CKJSON.swift
//  ORHP-Toolbox
//
//  Created by Corey Klass on 9/11/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation



extension Dictionary {
    
    func toJson() -> String? {
        var json: String?
        var errorText: String?
        
        // convert the JSON object to text
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
            json = String(data: jsonData, encoding: .utf8)
        }
        catch let error {
            errorText = error.localizedDescription
        }

        if (errorText != nil) {
            print("Error converting to JSON object:" + errorText!)
        }
        
        return json
    }
    
}



