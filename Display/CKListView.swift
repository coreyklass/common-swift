//
//  CKListView.swift
//  BlackBook
//
//  Created by Corey Klass on 3/10/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit

class CKListView: UIView {


    fileprivate var _rows = [CKListViewRow]()
    
    fileprivate var _rowSpacing: CGFloat = 0.0
    
    var rowSpacing: CGFloat {
        get {
            return self._rowSpacing
        }
        
        set {
            self._rowSpacing = newValue
            self.setNeedsUpdateConstraints()
        }
    }
    
    

    // returns the row count
    func rowCount() -> Int {
        return self._rows.count
    }
    
    
    // appends a row
    func appendRow(_ row: CKListViewRow) {
        let rowCount = self._rows.count
        
        self.insertRow(row, atIndex: rowCount)
    }
    
    
    // inserts a row at an index
    func insertRow(_ row: CKListViewRow, atIndex index: Int) {
        self._rows.insert(row, at: index)
        
        self.addSubview(row)
        
        self.setNeedsUpdateConstraints()
    }
    
    
    // deletes a row at an index
    func removeRowAtIndex(_ index: Int) {
        let row = self._rows[index]
        
        row.removeFromSuperview()
        
        self._rows.remove(at: index)
        
        self.setNeedsUpdateConstraints()
    }
    
    
    // deletes rows after the specified index
    func removeRowsAfterIndex(_ index: Int) {
        let rowIndex = index + 1
        
        while (rowIndex < self._rows.count) {
            self.removeRowAtIndex(rowIndex)
        }
        
        self.setNeedsUpdateConstraints()
    }
    
    
    
    // returns a row at an index
    func rowAtIndex(_ index: Int) -> CKListViewRow? {
        var row: CKListViewRow?
        
        if (index < self._rows.count) {
            row = self._rows[index]
        }
        
        return row
    }
    
    
    // returns the index for a row
    func indexForRow(_ row: CKListViewRow) -> Int? {
        var rowIndex: Int?
        
        for index in 0..<self._rows.count {
            if (self._rows[index].isEqual(row)) {
                rowIndex = index
            }
        }
        
        return rowIndex
    }
    
    
    
    // reconciles the row constraints
    fileprivate func reconcileSubviews() {
        self.setNeedsUpdateConstraints()
    }
    
    
    
    
    override func updateConstraints() {
        // remove existing constraints
        self.removeConstraints(self.constraints)
        
        
        // create some constraint objects
        let metrics: [String: CGFloat] = [
            "rowSpacing": self.rowSpacing
        ]
        
        var prevRow: CKListViewRow?
        var lastRow: CKListViewRow?
        
        // loop over the rows
        self._rows.forEach { (row: CKListViewRow) -> () in
            var views = [
                "row": row
            ]
            
            var constraintTexts = [
                "H:|[row]|"
            ]
            
            // if this is the first row
            if (prevRow == nil) {
                constraintTexts.append("V:|[row]")
            }
                
                // if this is not the first row
            else {
                views["prevRow"] = prevRow
                
                constraintTexts.append("V:[prevRow]-(rowSpacing)-[row]")
            }
            
            // generate constraints
            let constraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                constraintTexts,
                options: nil,
                metrics: metrics,
                views: views)
            
            constraints.forEach({ (constraint: NSLayoutConstraint) -> () in
                constraint.priority = 999
            })
            
            self.addConstraints(constraints)
            
            // we need the current row for stuff
            prevRow = row
            lastRow = row
            
            row.setNeedsUpdateConstraints()
        }
        
        // add a constraint for the last row
        if (lastRow != nil) {
            let views = [
                "lastRow": lastRow!
            ]
            
            let constraintTexts = [
                "V:[lastRow]|"
            ]
            
            // generate constraints
            let constraints = NSLayoutConstraint.multipleConstraintsWithVisualFormat(
                constraintTexts,
                options: nil,
                metrics: metrics,
                views: views)
            
            constraints.forEach({ (constraint: NSLayoutConstraint) -> () in
                constraint.priority = 999
            })
            
            self.addConstraints(constraints)
        }

        
        super.updateConstraints()
    }
    
    
    
    
}

















