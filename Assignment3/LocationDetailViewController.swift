//
//  LocationDetailViewController.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/23/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit
import Foundation

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var textviewtest: UITextView!
    var forcastService = SurfForcastService ()
    var currentLocation: LocationModel?
    var currentDayOfWeek: String?
    var hoursToday : [String] = [] //this will be maintained in order
    var todayForecastByHour = [ String : NSDictionary ]()
    //var todayForecast : [String : [S]]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        if let loc = currentLocation{
            getLocationDetails(loc.id)
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayData(){
        var textdisplay = ""
        for (key,value) in todayForecastByHour {
            textdisplay.appendContentsOf("\(key)"+" \(value)")
        }
        print(todayForecastByHour)
        print(hoursToday.description)
        textviewtest.text = textdisplay
    }
    
    func getLocationDetails(id: Int) {
        let apiEndpoint = self.forcastService.domain + self.forcastService.apiLocationId + String(id) + ".json" + self.forcastService.apiKey
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: apiEndpoint)!, completionHandler: { (data, response, error) -> Void in
         
            if error != nil {
                print("Error trying to get Location Info from swellcast \(error)")
                return
            } else if let d = data, let r = response as? NSHTTPURLResponse{
                if(r.statusCode == 200){
                    do{
                        let json: AnyObject = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments)
                        if let jsonDict = json as? NSDictionary {
                            let weatherArray = jsonDict.objectForKey("three_hourly_forecasts") as! NSArray
                            self.currentDayOfWeek = self.usersCurrentDayOfWeek() //ONE DAY OFF??!!?
                          
                            
                            for dayDict in weatherArray {
                                
                                //if it is today
                                    if dayDict["local_day"] as? String == self.currentDayOfWeek {
                                        let curhour = dayDict["local_hour"] as! String
                                        self.hoursToday.append(curhour)
                                        let swellheightmeters = dayDict["swell_height_metres"] as! String
                                        let swelldirection = dayDict["swell_direction_compass_point"] as! String
                                        let windspeedknots = dayDict["wind_speed_knots"] as! String
                                        let winddirection = dayDict["wind_direction_compass_point"] as! String
                                        self.todayForecastByHour[curhour] = ["swellHeightMeters": swellheightmeters, "swellDirection": swelldirection, "windSpeedKnots": windspeedknots, "windDirection": winddirection]
                                    }
                            }
                            //display data on view because loading is now complete
                            dispatch_async(dispatch_get_main_queue(), {
                                print("displaying data")
                                self.displayData()
                            })
                        }
                    } catch {
                        print("error retrieving data from server \(error)")
                    }
                }
            }
                
            })
            task.resume()
        }
    
    
    
    func usersCurrentDayOfWeek() -> String {
        let dateFormatter = NSDateFormatter()
        let cal = NSCalendar.currentCalendar()
        let dateComps = cal.components(NSCalendarUnit.Weekday , fromDate: NSDate())
        return dateFormatter.weekdaySymbols[dateComps.weekday]
    }

}
