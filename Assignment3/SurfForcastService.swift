//
//  SurfForcastService.swift
//  Assignment3
//
//  Created by Daniel Del Core on 18/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import Foundation

class SurfForcastService {
    
    let domain:String = "http://swellcast.com.au/"
    let apiKey:String = "?api_key=9t1xR2CE9zuyHGTxaTJg"
    let apiStates:String = "api/v1/states"
    let apiStateId:String = "api/v1/states/"
    let apiLocationId:String = "api/v1/locations/"
    
    func getStatesAll() {
        let apiEndpoint:String = self.domain + self.apiStates +  ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            var json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)!

            println(json)
            
        })
        task.resume()
    }
    
    func getStatesById(id: Int) {
        let apiEndpoint:String = self.domain + self.apiStateId + String(id) + ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            var json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)!
            
            println(json)
            
        })
        task.resume()
    }
    
    func getLocationById(id: Int) {
        let apiEndpoint:String = self.domain + self.apiLocationId + String(id) + ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            var json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)!
            
            println(json)
            
        })
        task.resume()
    }
    
    
}
