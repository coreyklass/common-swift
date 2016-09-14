//
//  CKZipArchiveWriter.swift
//  BlackBook
//
//  Created by Corey Klass on 4/8/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit

class CKZipArchiveWriter: NSObject {
    
    var zipFileURL: URL
    var password: String?
    var ssZipArchive: SSZipArchive
    
    
    // constructor
    init(zipFileURL: URL, overwriteIfExists: Bool) {
        self.zipFileURL = zipFileURL
        
        let fileManager = FileManager.default
        
        // if the zip file exists already, delete it
        if (overwriteIfExists && fileManager.fileExists(atPath: zipFileURL.relativePath)) {
            do {
                try fileManager.removeItem(at: zipFileURL)
            }
            catch let error as NSError {
                print("Error deleting file: " + zipFileURL.relativePath)
                print(error.localizedDescription)
            }
        }

        self.ssZipArchive = SSZipArchive(path: self.zipFileURL.relativePath)
        
        super.init()
    }

    
    
    // opens the zip file
    func open() -> Bool {
        return self.ssZipArchive.open
    }
    
    
    
    // adds a file to the zip file
    func addFile(_ fileURL: URL, toFolder zipFolder: String?) {
        // what is the filename to write to?
        var filename = fileURL.lastPathComponent
        
        if (zipFolder != nil) {
            filename = NSString(string: zipFolder!).appendingPathComponent(filename)
        }
        
        self.ssZipArchive.writeFile(
            atPath: fileURL.relativePath,
            withFileName: filename,
            withPassword: nil)
    }

    
    // adds a folder to a zip file
    func addFolderContent(_ folderURL: URL, toFolder zipFolderName: String, recurse: Bool) {
        let fileManager = FileManager.default
        
        // list the files in the folder
        var folderContents: [URL]?
        
        do {
            folderContents = try fileManager.contentsOfDirectory(
                at: folderURL,
                includingPropertiesForKeys: nil,
                options: FileManager.DirectoryEnumerationOptions(rawValue: 0))
        }
        catch let error as NSError {
            print("Error listing folder:" + folderURL.relativePath)
            print(error.localizedDescription)
        }
        
        // loop over the folder contents
        folderContents?.forEach { (objectURL: URL) in
            let isDirectory = fileManager.isDirectoryAtURL(objectURL)
            
            // if this is a directory, and we're recursing
            if (isDirectory && recurse) {
                let subFolderName = objectURL.lastPathComponent
                
                let subFolderURL = folderURL.appendingPathComponent(subFolderName)
                let zipSubFolderName = NSString(string: zipFolderName).appendingPathComponent(subFolderName)
                
                self.addFolderContent(
                    subFolderURL,
                    toFolder: zipSubFolderName,
                    recurse: recurse)
            }

            // if this not a directory
            else if (!isDirectory) {
                self.addFile(objectURL, toFolder: zipFolderName)
            }
        }
    }
    
    
    
    // closes the zip file
    func close() -> Bool {
        return self.ssZipArchive.close
    }
    

}
