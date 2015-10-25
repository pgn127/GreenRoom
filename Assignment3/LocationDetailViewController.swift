//
//  LocationDetailViewController.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/23/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit
import Foundation

class LocationDetailViewController: UITableViewController {
    
    //@IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textviewtest: UITextView!
    
    
    //@IBOutlet weak var textviewtest: UITextView!
    var forcastService = SurfForcastService ()
    var currentLocation: LocationModel?
    var currentDayOfWeek: String?
    var hoursToday : [String] = [] //this will be maintained in order
    var todayForecastByHour = [ String : NSDictionary ]()
    //var todayForecast : [String : [S]]
    var testItems = [forecastDisplay(swellHeight: "12", windSpeed: "20", time: "9AM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "12", windSpeed: "20", time: "12PM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "8", windSpeed: "20", time: "3PM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "12", windSpeed: "20", time: "6PM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "12", windSpeed: "20", time: "9PM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "12", windSpeed: "20", time: "11PM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "12", windSpeed: "20", time: "1AM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "12", windSpeed: "20", time: "4AM", swelldir: "NNW",winddir: "NNE"),forecastDisplay(swellHeight: "12", windSpeed: "20", time: "7AM", swelldir: "NNW",winddir: "NNE")]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        tableView.rowHeight = UITableViewAutomaticDimension
        if let loc = currentLocation{
            getLocationDetails(loc.id)
            self.navigationItem.title = loc.name
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        sizeHeaderToFit()
//    }
//    
//    func sizeHeaderToFit() {
//        let headerView = tableView.tableHeaderView!
//        
//        headerView.setNeedsLayout()
//        headerView.layoutIfNeeded()
//        
//        let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//        var frame = headerView.frame
//        frame.size.height = height
//        headerView.frame = frame
//        
//        tableView.tableHeaderView = headerView
//    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testItems.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = testItems[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("fCell", forIndexPath: indexPath) as! LocCell
        cell.cellInfo = item
        return cell
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
