//
//  TableViewController.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/23/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    let forcastService = SurfForcastService()
    var stateList: [StateModel] = []
    var locationList: [LocationModel] = []
    var beachSelected: BeachModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewController()
    }
    
    func initViewController() {
        if Reachability.isConnectedToNetwork() == true {
            // Internet connection OK
            self.initModels()
        } else {
            print("Internet connection FAILED")
            //alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            let resetAction = UIAlertAction(title: "Retry", style: .Default) { (action) in
                self.initViewController()
            }
            alertController.addAction(resetAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    override func viewWillAppear(animated: Bool){
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomTableViewCell {
        let item: LocationModel = self.locationList[indexPath.row]
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("listViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        cell.locationId = item.id
        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = self.getStateById(item.stateId)!.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as! CustomTableViewCell
        
        self.forcastService.getLocationById((currentCell.locationId)!, callback: { (response:BeachModel) -> () in
            self.beachSelected = response
            self.performSegueWithIdentifier("selectedItem", sender: self)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "selectedItem"){
            dispatch_async(dispatch_get_main_queue(), {
                let vc:BeachViewController = segue.destinationViewController as! BeachViewController
                vc.model = self.beachSelected
            })
        }
    }
    
    func initModels() {
        self.forcastService.getStatesAll({ (response) in
            self.stateList = response
            for state in self.stateList {
                self.forcastService.getLocationsByStateId(state.id, callback: { (locationResponse:[LocationModel]) -> () in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.locationList.appendContentsOf(locationResponse)
                        self.tableView.reloadData()
                    }
                })
            }
        })
    }
    
    func getStateById(id:Int) -> StateModel? {
        for state in self.stateList {
            if(state.id == id){
                return state
            }
        }
        
        return nil
    }
}
