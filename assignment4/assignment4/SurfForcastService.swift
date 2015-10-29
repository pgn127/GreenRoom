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

    //this function retrieves the state information from the url asynchronously  and creates a StateModel with the state info which is appended to the stateList Array.
    func getStatesAll(callback: ([StateModel]) -> ()) {
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

    func getLocationById(id: Int, callback: (BeachModel) -> ()) {
        let apiEndpoint:String = self.domain + self.apiLocationId + String(id) + ".json" + self.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            let json: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)

            var model: BeachModel = BeachModel()
            let id: Int = json["id"] as! Int
            let name: String = json["name"] as! String
            let slug: String = json["slug"] as! String
            let lat: String = json["latitude"] as! String
            let long: String = json["longitude"] as! String
            var forcastArray: [Forcast] = []

            if let jsonParse = json["three_hourly_forecasts"] as? [AnyObject] {
                for item in jsonParse {
                    let day: String = item["local_day"] as! String
                    let hour: String = item["local_hour"] as! String
                    let swellDirection: String = item["swell_direction_compass_point"] as! String
                    let swellDirectionDeg: String = item["swell_direction_degrees"] as! String
                    let swellHeightMetres: String = item["swell_height_metres"] as! String
                    let swellPeriod: String = item["swell_period_seconds"] as! String
                    let windDirection: String = item["wind_direction_compass_point"] as! String
                    let windDirectionDeg: String = item["wind_direction_degrees"] as! String
                    let windSpeed: String = item["wind_speed_knots"] as! String
                    let forcast = Forcast(day: day, hour: hour, swellDirection: swellDirection, swellDirectionDeg: Int(swellDirectionDeg)!,
                    swellHeightMetres: swellHeightMetres, swellPeriod: Int(swellPeriod)!, windDirection: windDirection, windDirectionDeg: Int(windDirectionDeg)!, windSpeed: windSpeed)

                    forcastArray.append(forcast)
                }
                model = BeachModel(id: id, name: name, slug: slug, lat: lat, long: long, forcastArray: forcastArray)
            }

            callback(model)
        })
        task.resume()
    }

}
