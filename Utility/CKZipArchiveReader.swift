//
//  CKZipArchiveReader.swift
//  BlackBook
//
//  Created by Corey Klass on 4/8/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import UIKit

class CKZipArchiveReader: NSObject {

    var zipFileURL: URL
    var password: String?
    var tag = 0
    
    
    // constructor
    init(zipFileURL: URL) {
        self.zipFileURL = zipFileURL

        super.init()
    }
    
    

    func unzipFileToFolderURL(_ folderURL: URL,
                              progressHandler: @escaping ((_ status: CKZipArchiveReaderStatus) -> Void),
                              completionHandler: @escaping ((_ folderURL: URL, _ success: Bool, _ error: NSError?) -> Void)) {
        // calls the 3rd party library
        SSZipArchive.unzipFile(
            atPath: self.zipFileURL.relativePath,
            toDestination: folderURL.relativePath,
            progressHandler: { (entryName: String?, zipInfo: unz_file_info, fileIndex: Int, totalFileCount: Int) -> Void in
                // called when each file is unzipped
                let status = CKZipArchiveReaderStatus(
                    reader: self,
                    filename: entryName!,
                    fileIndex: fileIndex,
                    totalFileCount: totalFileCount)
                
                progressHandler(status)
                },
            completionHandler: { (entryName: String?, success: Bool, error: Error?) -> Void in
                let errorObject = (error as? NSError)
                
                // called when we're done unzipping
                // completionHandler(folderURL: folderURL, success: success, error: error)
                completionHandler(folderURL, success, errorObject)
                })
    }
    
    
    
    
    
}




extension CKZipArchiveReader: SSZipArchiveDelegate {
    
    func zipArchiveDidUnzipFile(at fileIndex: Int, totalFiles: Int, archivePath: String!, unzippedFilePath: String!) {
        
    }
    
    
    func zipArchiveDidUnzipArchive(atPath path: String!, zipInfo: unz_global_info, unzippedPath: String!) {
        
    }
    
}






struct CKZipArchiveReaderStatus {
    var reader: CKZipArchiveReader
    var filename: String
    var fileIndex: Int
    var totalFileCount: Int
}


