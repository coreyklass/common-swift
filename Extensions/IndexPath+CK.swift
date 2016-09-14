//
//  NSIndexPath+CK.swift
//  BlackBook
//
//  Created by Corey Klass on 8/12/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension IndexPath {
    
    
    // returns the cell in the table view at the current index path
    func cellAtIndexPathInTable(_ tableView: UITableView) -> UITableViewCell? {
        let cell = tableView.cellForRow(at: self)
        return cell
    }
    
    
}


