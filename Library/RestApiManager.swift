//
//  RestApiManager.swift
//  Library
//
//  Created by Jason on 8/20/15.
//  Copyright © 2015 IIT. All rights reserved.
//

import Foundation


typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://216.47.136.92:8080/"
    
    func getNames(path: String, onCompletion: (JSON) -> Void) {
        let route = baseURL + path
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })

    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        var newpath = path.componentsSeparatedByString(" ")
        var path1 = ""
        for var index = 0; index < newpath.count; index++ {
            if(index < (newpath.count - 1))
            {
                path1 += newpath[index] + "%20"
            }
            else
            {
                path1 += newpath[index]
            }
        }
            
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: path1)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task!.resume()
    }
}