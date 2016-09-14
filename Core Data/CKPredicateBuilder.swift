//
//  CKPredicateBuilder.swift
//  BlackBook
//
//  Created by Corey Klass on 5/12/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit
import CoreData


class CKPredicateBuilder: NSObject {

    // how we join the predicates
    var joinType: CKPredicateBuilderJoinType = .and
    
    
    // holds all of the predicates
    fileprivate var _predicates = [CKPredicate]()
    
    var predicates: [CKPredicate] {
        get {
            let predicates = self._predicates
            return predicates
        }
    }

    
    
    
    // constructor
    override init() {
        super.init()
    }
    
    
    // adds a predicate
    func appendPredicate(_ predicate: CKPredicate) {
        self._predicates.append(predicate)
    }
    
    
    // removes a predicate
    func removePredicate(_ predicate: CKPredicate) {
        let predicateIndex = self._predicates.index(of: predicate)
        
        if (predicateIndex != nil) {
            self._predicates.remove(at: predicateIndex!)
        }
    }
    
    
    // joins all existing predicates
    func joinPredicates() -> CKPredicate {
        let joinPredicate = CKPredicate()
        
        // grab the predicates
        let predicates = self._predicates
        
        // loop over existing predicates
        for predicateIndex in 0..<predicates.count {
            let predicate = predicates[predicateIndex]
            
            // append the current predicate
            joinPredicate.predicateFormat += "( " + predicate.predicateFormat + ") "
            
            // append the predicate arguments
            joinPredicate.appendArguments(predicate.predicateArguments)
            
            // if this isn't the last predicate
            if (predicateIndex < (predicates.count-1)) {
                switch (self.joinType) {
                    case .and:
                        joinPredicate.predicateFormat += " and "
                    case .or:
                        joinPredicate.predicateFormat += " or "
                }
            }
            
        } // for predicateIndex in 0..<predicates.count
        
        return joinPredicate
    }
    
    
    // creates an NSPredicate
    func createNSPredicate() -> NSPredicate {
        let predicate = self.joinPredicates().createNSPredicate()
        return predicate
    }
    
    
    
}



// individual predicates
class CKPredicate: NSObject {
    
    var predicateFormat: String
    var predicateArguments: [AnyObject]
    
    // constructor
    override init() {
        self.predicateFormat = ""
        self.predicateArguments = []
        
        super.init()
    }
    
    
    // constructor
    init(format: String, argumentArray: [AnyObject]) {
        self.predicateFormat = format
        self.predicateArguments = argumentArray
        
        super.init()
    }
    
    
    // constructor
    init(context: NSManagedObjectContext, format: String, entityArray: [[AnyObject]]) {
        self.predicateFormat = format
        
        var managedObjectArrays = [[NSManagedObject]]()
        
        entityArray.forEach { (entitySubArray: [AnyObject]) in
            var managedObjects = [NSManagedObject]()
            
            entitySubArray.forEach({ (object: AnyObject) in
                let entity = (object as! CKCoreDataEntity)
                
                if (entity.objectID != nil) {
                    let managedObject = context.object(with: entity.objectID!)
                    managedObjects.append(managedObject)
                }
            })
            
            managedObjectArrays.append(managedObjects)
        }
        

        self.predicateArguments = managedObjectArrays as [AnyObject]

        
        super.init()
    }
    
    
    
    // appends a single argument to the array
    func appendArgument(_ argument: AnyObject) {
        self.predicateArguments.append(argument)
    }
    
    
    // appends the arguments to the array
    func appendArguments(_ argumentArray: [AnyObject]) {
        self.predicateArguments.append(contentsOf: argumentArray)
    }
    
    
    // creates an NSPredicate object
    func createNSPredicate() -> NSPredicate {
        let predicate = NSPredicate(format: self.predicateFormat, argumentArray: self.predicateArguments)
        return predicate
    }
    
}







// the type for the join
enum CKPredicateBuilderJoinType {
    case and
    case or
}


// objects have to match this protocol
protocol CKCoreDataEntity {
    
    var objectID: NSManagedObjectID? { get }
    var guid: String { get }
    
}









