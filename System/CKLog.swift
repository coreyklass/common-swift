//
//  CKLog.swift
//  Watchboard
//
//  Created by Corey Klass on 10/26/15.
//  Copyright © 2015 Corey Klass. All rights reserved.
//

import UIKit

class CKLog: NSObject {
    
    var logPath: String
    var logText: [String]

    // http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
    let dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    
    lazy var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.dateFormat
        return dateFormatter
    }()
    
    
    // constructor
    init(logPath: String) {
        self.logPath = logPath
        self.logText = [String]()
        
        print("** Logging to file:")
        print(self.logPath)
        
        super.init()
    }
    
    
    // does the log file exist?
    func logFileExists() -> Bool {
        let fileManager = FileManager.default
        
        // does the file already exist?
        let fileExists = fileManager.fileExists(atPath: self.logPath)

        return fileExists
    }
    
    
    
    
    
    // create a new file
    func createNewFile() {
        let fileManager = FileManager.default
        
        // does the file already exist?
        let fileExists = self.logFileExists()
        
        // if the file exists, delete it
        if (fileExists) {
            do {
                try fileManager.removeItem(atPath: self.logPath)
            }
            catch let error as NSError {
                print("Error deleting old file:")
                print(error.localizedDescription)
            }
        }

        // create a new empty file
        let data = Data()

        do {
            let url = URL(fileURLWithPath: self.logPath, isDirectory: false)
            try data.write(to: url, options: NSData.WritingOptions.atomic)
        }
        catch let error as NSError {
            print("Error creating new file:")
            print(error.localizedDescription)
        }
    }
    
    
    
    // appends to the log file
    func appendText(_ text: String) {
        // create the time for the start of the line
        let logTime = Date()
        let logTimeText = self.dateFormatter.string(from: logTime)
        
        // build the text to output
        var logLineText = logTimeText
        logLineText = logLineText + ": "
        logLineText = logLineText + text
        
        self.logText.append(logLineText)
        
        print(logLineText)
        
        // convert to NSData
        let logLineTextCR = logLineText + "\n"
        let logLineData = logLineTextCR.data(using: String.Encoding.utf8)
        
        // if the log file doesn't exist, create it
        if (!self.logFileExists()) {
            self.createNewFile()
        }
        
        // if there is a log line
        if (logLineData != nil) {
            // grab a file handle for the file
            let fileHandle = FileHandle(forUpdatingAtPath: self.logPath)
            
            if (fileHandle == nil) {
                print("Error grabbing file handle")
            }
            
            else {
                // seek to the end of the file and append the data
                fileHandle!.seekToEndOfFile()
                fileHandle!.write(logLineData!)
                fileHandle!.closeFile()
            }
        }
    }
    

}
