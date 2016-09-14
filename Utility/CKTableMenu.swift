//
//  CKTableMenu.swift
//  CountdownTimer
//
//  Created by Corey Klass on 10/10/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import UIKit

class CKTableMenu: NSObject {
   
    var tableView : UITableView
    
    var sections : [CKTableMenuSection]
    

    // constructor
    init (tableView : UITableView) {
        self.tableView = tableView
        
        self.sections = [CKTableMenuSection]()
        
        super.init()
    }
    
    
    // appends a section
    func appendSection(_ tag : Int) {
        let section = CKTableMenuSection(tag: tag)
        self.sections.append(section)
    }
    
    
    // appends a row to the last section
    func appendRowToSection(_ tag : Int) {
        let section = self.sections.last!
        section.appendRow(tag)
    }

    
    // returns the number of sections
    func numberOfSections() -> Int {
        let sectionCount = self.sections.count
        return sectionCount
    }
    
    
    // returns the number of rows in the section
    func numberOfRowsInSectionByIndex(_ sectionIndex : Int) -> Int {
        let section = self.sections[sectionIndex]
        let rowCount = section.numberOfRows()
        return rowCount
    }
    
    
    // returns the section tag for a given section index
    func sectionTagForIndex(section sectionIndex: Int) -> Int {
        let section = self.sections[sectionIndex]
        return section.tag
    }
    
    
    // returns the row tag for a given index path
    func rowTagForIndexPath(_ indexPath : IndexPath) -> Int {
        let sectionIndex = (indexPath as IndexPath).section
        let rowIndex = (indexPath as IndexPath).row
        
        let section = self.sections[sectionIndex]
        
        var rowTag = 0
        
        if (rowIndex < section.rows.count) {
            rowTag = section.rows[rowIndex]
        }
        
        return rowTag
    }
    
    
    // returns the section index
    func indexForSectionTag(_ tag: Int) -> Int? {
        var sectionIndex: Int?
        
        for testIndex in 0..<self.sections.count {
            let section = self.sections[testIndex]
            
            if (section.tag == tag) {
                sectionIndex = testIndex
                break
            }
        }
        
        return sectionIndex
    }
    
    
    // returns the index path for a tag
    func indexPathForRowTag(_ tag : Int) -> IndexPath? {
        var indexPath : IndexPath?
        
        var sectionIndex = 0
        
        while ((indexPath == nil) && (sectionIndex < self.sections.count)) {
            var rowIndex = 0
            let section = self.sections[sectionIndex]
            
            while ((indexPath == nil) && (rowIndex < section.rows.count)) {
                let rowTag = section.rows[rowIndex]
                
                if (rowTag == tag) {
                    indexPath = IndexPath(row: rowIndex, section: sectionIndex)
                }
                
                rowIndex += 1
            }
            
            sectionIndex += 1
        }
        
        return indexPath
    }
    
    
    
    // transitions the table view to a new table menu
    func transitionTableViewToNewTableMenu(_ tableMenu: CKTableMenu, commitUpdates : Bool) {
        
        if (commitUpdates) {
            self.tableView.beginUpdates()
        }
        

        
        
        
        // look for row deletions in existing sections
        var deleteIndexPaths = [IndexPath]()
        
        (0..<self.sections.count).forEach { (existingSectionIndex: Int) in
            let existingSection = self.sections[existingSectionIndex]
            
            tableMenu.sections.forEach({ (newSection: CKTableMenu.CKTableMenuSection) in
                // if the section exists in the old and new menus
                if (newSection.tag == existingSection.tag) {
                    // starting at the last row
                    var existingRowIndex = existingSection.rows.count - 1
                    
                    while (existingRowIndex >= 0) {
                        // default that we're deleting the row
                        var deleteRow = true
                        
                        // grab the tag from the existing row
                        let existingRowTag = existingSection.rows[existingRowIndex]
                        
                        // look for the tag in the new section
                        let newRowIndex = newSection.rows.index(of: existingRowTag)
                        
                        // if the tag is found in the new section, cancel the deletion
                        if (newRowIndex != nil) {
                            deleteRow = false
                        }
                        
                        // if we're deleting the row
                        if (deleteRow) {
                            existingSection.rows.remove(at: existingRowIndex)

                            let indexPath = IndexPath(row: existingRowIndex, section: existingSectionIndex)
                            deleteIndexPaths.append(indexPath)
                        }
                        
                        existingRowIndex -= 1
                    }
                    
                }
            })
        }

        if (deleteIndexPaths.count > 0) {
            self.tableView.deleteRows(at: deleteIndexPaths, with: .fade)
        }
        
        
        
        // look for row insertions in existing sections
        var insertIndexPaths = [IndexPath]()
        
        (0..<self.sections.count).forEach { (existingSectionIndex: Int) in
            let existingSection = self.sections[existingSectionIndex]
            
            tableMenu.sections.forEach({ (newSection: CKTableMenu.CKTableMenuSection) in
                // if the section exists in the old and new menus
                if (newSection.tag == existingSection.tag) {
                    // loop over the new rows
                    (0..<newSection.rows.count).forEach({ (newRowIndex: Int) in
                        let newRowTag = newSection.rows[newRowIndex]
                        
                        // look for the new row tag in the existing section
                        let existingRowIndex = existingSection.rows.index(of: newRowTag)
                        
                        // if the new row tag doesn't exist
                        if (existingRowIndex == nil) {
                            existingSection.rows.insert(newRowTag, at: newRowIndex)

                            let indexPath = IndexPath(row: newRowIndex, section: existingSectionIndex)
                            insertIndexPaths.append(indexPath)
                        }
                    })
                }
            })
        }
        
        if (insertIndexPaths.count > 0) {
            self.tableView.insertRows(at: insertIndexPaths, with: .fade)
        }
        
        
        
        // look for section deletions, starting at the end
        var existingSectionIndex = self.sections.count - 1
        
        while (existingSectionIndex >= 0) {
            let existingSection = self.sections[existingSectionIndex]
            
            // default that we're deleting the section
            var deleteSection = true
            
            // loop over the new sections; if the same one is found, cancel the deletion
            tableMenu.sections.forEach({ (newSection: CKTableMenu.CKTableMenuSection) in
                if (existingSection.tag == newSection.tag) {
                    deleteSection = false
                }
            })
            
            // if we're deleting the section
            if (deleteSection) {
                self.sections.remove(at: existingSectionIndex)

                let indexSet = IndexSet(integer: existingSectionIndex)
                self.tableView.deleteSections(indexSet, with: .fade)
            }
            
            existingSectionIndex -= 1
        }
        
        
        // look for section insertions
        (0..<tableMenu.sections.count).forEach { (newSectionIndex: Int) in
            let newSection = tableMenu.sections[newSectionIndex]
            
            // default that we're inserting the section
            var insertSection = true
            
            // look for the new section in the existing stack; if it's found, cancel the insert
            self.sections.forEach({ (existingSection: CKTableMenu.CKTableMenuSection) in
                if (existingSection.tag == newSection.tag) {
                    insertSection = false
                }
            })
            
            // if we're inserting the section
            if (insertSection) {
                self.sections.insert(newSection, at: newSectionIndex)

                let indexSet = IndexSet(integer: newSectionIndex)
                self.tableView.insertSections(indexSet, with: .fade)
            }
        }
        
        
        // check row tags
        (0..<tableMenu.sections.count).forEach { (newSectionIndex: Int) in
            let existingSection = self.sections[newSectionIndex]
            let newSection = tableMenu.sections[newSectionIndex]
            
            (0..<newSection.rows.count).forEach({ (newRowIndex: Int) in
                let existingRowTag = existingSection.rows[newRowIndex]
                let newRowTag = newSection.rows[newRowIndex]
                
                if (existingRowTag != newRowTag) {
                    existingSection.rows[newRowIndex] = newRowTag
                    
                    let indexPath = IndexPath(row: newRowIndex, section: newSectionIndex)
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            })
        }
        
        
        // check section tags
        (0..<tableMenu.sections.count).forEach { (newSectionIndex: Int) in
            let existingSection = self.sections[newSectionIndex]
            let newSection = tableMenu.sections[newSectionIndex]
            
            if (existingSection.tag != newSection.tag) {
                self.sections[newSectionIndex] = newSection
                
                let indexSet = IndexSet(integer: newSectionIndex)
                self.tableView.reloadSections(indexSet, with: .fade)
            }
        }
        
        
        
        if (commitUpdates) {
            self.tableView.endUpdates()
        }
        
    }
    
    
    
    // determines if this table menu matches another
    func equals(_ tableMenu : CKTableMenu) -> Bool {
        
        let matchesFlag = true
        
        
        return matchesFlag
        
    }
    
    
    
    
    // section inner class
    class CKTableMenuSection {
    
        var tag : Int = 0
        var rows = [Int]()
        
        
        init(tag : Int) {
            self.tag = tag
        }
        
        
        // appends a row
        func appendRow(_ tag : Int) {
            self.rows.append(tag)
        }
        
        
        // retrieves a row by index
        func rowTagByIndex(_ rowIndex : Int) -> Int {
            let tag = self.rows[rowIndex]
            return tag
        }
        
        
        // row count
        func numberOfRows() -> Int {
            return self.rows.count
        }
        
    } // CKTableMenuSection
    
    
    
} // CKTableMenu



