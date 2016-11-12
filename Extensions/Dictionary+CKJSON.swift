//
//  Dictionary+CKJSON.swift
//  ORHP-Toolbox
//
//  Created by Corey Klass on 9/11/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation



extension Dictionary {
    
    
    func toJsonData() -> Data? {
        var jsonData: Data?
        
        // convert the JSON object to datda
        do {
            jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
        }
        catch let error {
            print("Error converting to JSON object:")
            print(error.localizedDescription)
        }
        
        return jsonData
    }
    
    
    func toJson() -> String? {
        var json: String?
        
        if let jsonData = self.toJsonData() {
            json = String(data: jsonData, encoding: .utf8)
        }
        
        return json
    }
    
}



