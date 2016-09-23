//
//  NSFileManager+CKExtensions.swift
//  BlackBook
//
//  Created by Corey Klass on 4/7/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation


extension FileManager {

    func isDirectoryAtURL(_ url: URL) -> Bool {
        // we need an Objective-C boolean
        var isDirectory: ObjCBool = ObjCBool(false)
        
        // determine if this is a directory
        self.fileExists(atPath: url.relativePath, isDirectory: &isDirectory)
        
        // convert to a Swift Boolean
        let isDirectoryBool = isDirectory.boolValue
        
        // return the Swift boolean
        return isDirectoryBool
    }

    
    
    // creates the directory if needed
    func createDirectoryIfNeeded(url: URL) -> Error? {
        let directoryExists = self.isDirectoryAtURL(url)
        var returnError: Error?
        
        if (!directoryExists) {
            do {
                try self.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print("Error creating directory:")
                print(error.localizedDescription)
                
                returnError = error
            }
        }
        
        return returnError
    }
    
    
    

    // removes an item at the URL, optionally recursively
    func removeItemAtURL(_ url: URL, recurse: Bool) -> Bool {
        let fileProperties: [URLResourceKey] = [.nameKey, .isDirectoryKey]
        
        var allowDelete = true

        // is this a directory?
        let isDirectory = self.isDirectoryAtURL(url)
        
        // if this is a directory
        if (isDirectory) {
            if (recurse) {
                // list the contents
                var contents: [URL]?
                
                do {
                    // retrieve file contents
                    contents = try self.contentsOfDirectory(
                        at: url,
                        includingPropertiesForKeys: fileProperties,
                        options: FileManager.DirectoryEnumerationOptions(rawValue: 0))
                }
                catch let error as NSError {
                    allowDelete = false
                    
                    print("Error listing folder contents:" + url.relativePath)
                    print(error.localizedDescription)
                }
                
                // loop over the contents and delete the items
                contents?.forEach({ (contentURL: URL) in
                    _ = self.removeItemAtURL(contentURL, recurse: recurse)
                })
            }
                
            else {
                allowDelete = false
            }
        }
        

        // we only do this if we've been successful so far
        if (allowDelete) {
            do {
                // now we can delete the object
                try self.removeItem(at: url)
            }
            catch let error as NSError {
                allowDelete = false
                
                print("Error deleting item:" + url.relativePath)
                print(error.localizedDescription)
            }
        }

        
        return allowDelete
    }

    
    
    
    // copies the contents of one folder to another
    func copyContentsFromFolderURL(_ sourceURL: URL, toFolderURL destURL: URL, overwrite: Bool, moveFlag: Bool) {
        let fileProperties: [URLResourceKey] = [.nameKey, .isDirectoryKey]

        var sourceContents: [URL]?
        
        // list the contents of the source URL
        do {
            sourceContents = try self.contentsOfDirectory(
                at: sourceURL,
                includingPropertiesForKeys: fileProperties,
                options: FileManager.DirectoryEnumerationOptions(rawValue: 0))
        }
        catch let error as NSError {
            print("Error listing source folder:")
            print(error.localizedDescription)
        }
        
        // loop over the contents
        sourceContents?.forEach { (contentURL: URL) in
            let destObjectURL = destURL.appendingPathComponent(contentURL.lastPathComponent)

            // if this is a folder
            if (self.isDirectoryAtURL(contentURL)) {
                // create the folder if it doesn't exist
                if (!self.fileExists(atPath: destObjectURL.relativePath)) {
                    do {
                        try self.createDirectory(at: destObjectURL,
                            withIntermediateDirectories: true,
                            attributes: nil)
                    }
                    catch let error as NSError {
                        print("Error creating folder:")
                        print(error.localizedDescription)
                    }
                }
                
                // recursively call this function
                self.copyContentsFromFolderURL(
                    contentURL,
                    toFolderURL: destObjectURL,
                    overwrite: overwrite,
                    moveFlag: moveFlag)
            }
            
            // if it's a file
            else {
                // if the file exists and we're overwriting it
                if (self.fileExists(atPath: destObjectURL.relativePath) && overwrite) {
                    do {
                        try self.removeItem(at: destObjectURL)
                    }
                    catch let error as NSError {
                        print("Error deleting file:")
                        print(error.localizedDescription)
                    }
                }
                
                // if we're moving the file
                if (moveFlag) {
                    do {
                        try self.moveItem(
                            at: contentURL,
                            to: destObjectURL)
                    }
                    catch let error as NSError {
                        print("Error moving file:")
                        print(error.localizedDescription)
                    }
                }
                    
                // else if we're copying the file
                else {
                    do {
                        try self.copyItem(
                            at: contentURL,
                            to: destObjectURL)
                    }
                    catch let error as NSError {
                        print("Error moving file:")
                        print(error.localizedDescription)
                    }
                }
                
            } // else if it's a file
                
        } // sourceContents?.forEach
        
    } // copyContentsFromFolderURL()
    
    
}




