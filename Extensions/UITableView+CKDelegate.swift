//
//  UITableView+CKDelegate.swift
//  BlackBook
//
//  Created by Corey Klass on 4/19/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {

    // removes the separator inset for a cell
    func removeSeparatorInsetForCell(_ cell: UITableViewCell) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
    }
    
    
    // appends a row to the end of the table
    func appendRowToSection(_ section: Int, animation: UITableViewRowAnimation) {
        let rowCount = self.numberOfRows(inSection: section)
        let indexPath = IndexPath(row: rowCount, section: section)
        
        self.insertRows(at: [indexPath], with: animation)
    }
    
    
    // deletes rows from the specified index path
    func deleteRowsFromIndexPath(_ indexPath: IndexPath, animation: UITableViewRowAnimation) {
        let rowCount = self.numberOfRows(inSection: (indexPath as IndexPath).section)
        
        if (rowCount > (indexPath as IndexPath).row) {
            var indexPaths = [IndexPath]()
            
            for rowIndex in (indexPath as IndexPath).row..<rowCount {
                let tempIndexPath = IndexPath(row: rowIndex, section: (indexPath as IndexPath).section)
                indexPaths.append(tempIndexPath)
            }
            
            self.deleteRows(at: indexPaths, with: animation)
        }
        
    }
    
    
}

