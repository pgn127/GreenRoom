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
    
    func getStatesAll(callback: ([StateModel]) -> ()) {
        let apiEndpoint:String = self.domain + self.apiStates +  ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            var json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)!
            var stateList:[StateModel] = []
            
            if let jsonParse = json as? [AnyObject] {
                for item in jsonParse {
                    var id:Int = item["id"] as! Int
                    var name:String = item["name"] as! String
                    var model = StateModel(id: id, name: name)
                    stateList.append(model)
                }
            }
            
            callback(stateList)
        })
        task.resume()
    }
    
    func getLocationsByStateId(id: Int, callback: ([LocationModel]) -> ()) {
        let apiEndpoint:String = self.domain + self.apiStateId + String(id) + ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            var json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)!
            var locationList:[LocationModel] = []
            var stateId:Int = json["id"] as! Int
            
            if let jsonParse = json["locations"] as? [AnyObject] {
                for item in jsonParse {
                    var id:Int = item["id"] as! Int
                    var name:String = item["name"] as! String
                    var lat: String = item["latitude"] as! String
                    var long: String = item["longitude"] as! String
                    var model = LocationModel(id: id, name: name, stateId: stateId, lat: NSString(string: lat).doubleValue, long: NSString(string: long).doubleValue)
                    locationList.append(model)
                }
            }
            
            callback(locationList)
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

