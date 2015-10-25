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
        //this function retrieves the state information from the url asynchronously  and creates a StateModel with the state info which is appended to the stateList Array.
        let apiEndpoint:String = self.domain + self.apiStates +  ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            let json: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            var stateList:[StateModel] = []
            
            if let jsonParse = json as? [AnyObject] {
                for item in jsonParse {
                    let id:Int = item["id"] as! Int
                    let name:String = item["name"] as! String
                    let model = StateModel(id: id, name: name)
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
            let json: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            var locationList:[LocationModel] = []
            let stateId:Int = json["id"] as! Int
            
            if let jsonParse = json["locations"] as? [AnyObject] {
                for item in jsonParse {
                    let id:Int = item["id"] as! Int
                    let name:String = item["name"] as! String
                    let lat: String = item["latitude"] as! String
                    let long: String = item["longitude"] as! String
                    let model = LocationModel(id: id, name: name, stateId: stateId, lat: NSString(string: lat).doubleValue, long: NSString(string: long).doubleValue)
                    locationList.append(model)
                }
            }
            
            callback(locationList)
        })
        task.resume()
    }
    
//    func getStateLocationDict() -> [StateModel : LocationModel]{
//        
//        let apiEndpoint:String = self.domain + self.apiStates +  ".json" + self.apiKey
//        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
//            if error != nil {
//                print("Error trying to GET from swellcast \(error)")
//                return
//            } else if let d = data, let r = response as? NSHTTPURLResponse{
//                if(r.statusCode == 200){
//                    do{
//                        var stateLocDict = [StateModel : LocationModel]()
//                        let json: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
//                        if let jsonParse = json as? [AnyObject] {
//                            for item in jsonParse {
//                                let id:Int = item["id"] as! Int
//                                let name:String = item["name"] as! String
//                                let currentState = StateModel(id: id, name: name)
//                                
//                            }
//                        }
//                    }
//                }
//            }
//
//            let json: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
//            var stateList:[StateModel] = []
//            
//            if let jsonParse = json as? [AnyObject] {
//                for item in jsonParse {
//                    let id:Int = item["id"] as! Int
//                    let name:String = item["name"] as! String
//                    let model = StateModel(id: id, name: name)
//                    stateList.append(model)
//                }
//            }
//            
//            callback(stateList)
//        })
//        task.resume()
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        let apiEndpoint:String = self.domain + self.apiStateId + String(id) + ".json" + self.apiKey
//        let session = NSURLSession.sharedSession()
//        let request = NSMutableURLRequest(URL: NSURL(string: apiEndpoint)!)
//        request.HTTPMethod = "GET"
//        let task = session.dataTaskWithRequest(request,
//            completionHandler: {(data, response, error) -> Void in
//                if error != nil {
//                    print("Error trying to GET from swellcast \(error)")
//                } else if let d = data, let r = response as? NSHTTPURLResponse{
//                    if(r.statusCode == 200){
//                        do{
//                            let json: AnyObject = try! NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments)
//                            if let jsonParse = json["locations"] as? [AnyObject] {
//                                for item in jsonParse {
//                                    let id:Int = item["id"] as! Int
//                                    let name:String = item["name"] as! String
//                                    let lat: String = item["latitude"] as! String
//                                    let long: String = item["longitude"] as! String
//                                    let model = LocationModel(id: id, name: name, stateId: stateId, lat: NSString(string: lat).doubleValue, long: NSString(string: long).doubleValue)
//                                    locationList.append(model)
//                                }
//                            }
//                            
//                        } catch {
//                            print("json error")
//                        }
//                    }
//                }
//                
//        })
//        //print("perform function reached")
//        task.resume()
//        
//    }
//
//    
//    }
    
    func getLocationById(id: Int) {
        let apiEndpoint:String = self.domain + self.apiLocationId + String(id) + ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            let json: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            
            print(json)
            
        })
        task.resume()
    }
    
}

