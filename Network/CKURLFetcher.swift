//
//  CKURLFetcher.swift
//  MalcontentBoffin
//
//  Created by Corey Klass on 7/1/14.
//  Copyright (c) 2014 Corey Klass. All rights reserved.
//

import UIKit

class CKURLFetcher: NSObject, URLSessionDelegate {

    var tag: Int?
    var urlString: String = ""
    var urlVars: [String: String]?
    var formVars: [String: String]?
    
    var timeoutIntervalForRequest: TimeInterval?
    var timeoutIntervalForResource: TimeInterval?
    
    var completionHandler: ((_ urlFetcher: CKURLFetcher) -> Void)?
    var completionHandlerBackgroundThread = false
    
    
    // Is the fetch running
    fileprivate var _isFetchRunning = false
    
    var isFetchRunning: Bool {
        get {
            return self._isFetchRunning
        }
    }
    
    
    // Response data
    fileprivate var _responseData: Data?
    
    var responseData: Data? {
        get {
            return self._responseData
        }
    }
    
    
    // Response
    fileprivate var _response: URLResponse?
    
    var response: URLResponse? {
        get {
            return self._response
        }
    }
    
    
    // Response error
    fileprivate var _responseError: NSError?
    
    var responseError: NSError? {
        get {
            return self._responseError
        }
    }

    
    
    // constructor
    override init() {
        super.init()
    }
    
    
    // initiates the URL fetch
    func initiateURLFetch() {
        var urlStringToFetch = self.urlString

        // convert the URL vars to a query string
        let urlQueryString = self.urlVars?.toURLString() ?? ""
        
        // if there is a query string
        if (urlQueryString != "") {
            urlStringToFetch += (urlStringToFetch.contains("?") ? "&" : "?") + urlQueryString
        }
        
        print("Fetching URL: " + urlStringToFetch)
        

        // build a session configuration
        let sessionConfig = URLSessionConfiguration.default
        
        if (self.timeoutIntervalForRequest != nil) {
            sessionConfig.timeoutIntervalForRequest = self.timeoutIntervalForRequest!
        }
        
        if (self.timeoutIntervalForResource != nil) {
            sessionConfig.timeoutIntervalForResource = self.timeoutIntervalForResource!
        }
        
        let session = URLSession(configuration: sessionConfig)
        
        let urlToFetch = URL(string: urlStringToFetch)
        
        // set up the data task
        let dataTask = session.dataTask(with: urlToFetch!) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            self.didFinishFetchingData(data: data, urlResponse: urlResponse, error: error)
        }
        
        
        // execute the data fetch task
        dataTask.resume()
        
        self._isFetchRunning = true
    }

    
    
    // finished fetching data
    fileprivate func didFinishFetchingData(data: Data?, urlResponse: URLResponse?, error: Error?) -> Void {
        self._responseData = data
        self._response = urlResponse
        self._responseError = (error as? NSError)
        
        self._isFetchRunning = false
        
        // if an error was returned
        if (self.responseError != nil) {
            print("Error fetching URL:")
            print(self.responseError!.localizedDescription)
        }

        
        // call the result on the background thread
        if (self.completionHandlerBackgroundThread) {
            self.completionHandler?(self)
        }

        // call the result on the main thread
        else {
            DispatchQueue.main.async {
                self.completionHandler?(self)
            }
        }
    }
    
    

}






