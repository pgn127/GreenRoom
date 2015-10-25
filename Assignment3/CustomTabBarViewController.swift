//
//  CustomTabBarViewController.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/23/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    
    var forcastService = SurfForcastService()

    override func viewDidLoad() {
        super.viewDidLoad()
        initModels()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initModels() {
        self.forcastService.getStatesAll({ (response) in
            self.stateList = response
            for state in self.stateList {
                self.forcastService.getLocationsByStateId(state.id!, callback: { (locationResponse:[LocationModel]) -> () in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.locationList.appendContentsOf(locationResponse)
                        for location in locationResponse {
                            self.addPinToMap(location.lat, long: location.long, title: location.name)
                        }
                    }
                })
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
