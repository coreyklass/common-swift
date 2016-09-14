//
//  NSManagedObjectContext+CK.swift
//  BlackBook
//
//  Created by Corey Klass on 7/3/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import CoreData


extension NSManagedObjectContext {
    
    
    // returns a managed object for an entity with the specified GUID
    func objectWithGUID(_ guid: String, forEntity entity: String) -> NSManagedObject? {
        // set up the request for the entity
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        // build the predicate by GUID
        request.predicate = NSPredicate(format: "guid = %@", argumentArray: [guid])
        
        // look for the entity
        var managedObject: NSManagedObject?
        
        do {
            let managedObjects = (try self.fetch(request) as? [NSManagedObject])
            managedObject = managedObjects?.first
        }
        catch let error as NSError {
            let errorText = "Error retrieving entity \"" + entity + "\" with GUID \"" + guid + "\":\n" + error.localizedDescription
            print(errorText)
        }
        
        return managedObject
    }
    
    
    
    // returns the count of managed objects
    func countForFetchRequest(_ request: NSFetchRequest<NSFetchRequestResult>) -> Int {
        var count: Int = 0
        
        do {
            count = try self.count(for: request)
        }
        catch let error as NSError {
            print("Error retrieving count: ")
            print(error.localizedDescription)
        }
        
        return count
    }
    
}


