//
//  TableViewController.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/23/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var stateList:[StateModel] = []
    var locationList: [LocationModel] = []
    var tableData:[Objects] = []
    var stateLocDict: [StateModel:[LocationModel]]?
    var forcastService = SurfForcastService ()
    
    
    struct Objects {
        
        var sectionName : String
        var sectionObjects : [LocationModel]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil, userInfo: nil)
        
//        let barViewControllers = self.tabBarController?.viewControllers
//        let svc = barViewControllers![0] as! MapViewController
//        svc.stateList = self.stateList
//        svc.locationList = self.locationList
//        svc.stateLocDict = self.stateLocDict!
        if let dict = stateLocDict {
        for (key, value) in dict {
             tableData.append(Objects(sectionName: key.name, sectionObjects: value))
        }
        }
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
//        
//        let barViewControllers = self.tabBarController?.viewControllers
//        let svc = barViewControllers![2] as! ListViewController
//        //let tbvc = tabBarController as! CustomTabBarViewController
//        svc.forcastService = self.forcastService
//        //forecastService = tbvc.forecastService
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableData.count
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowCount = 0
        if !tableData.isEmpty {
            rowCount = tableData[section].sectionObjects.count

        }
            return rowCount
        }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("loc", forIndexPath: indexPath)
        if !tableData.isEmpty{
            cell.textLabel?.text = tableData[indexPath.section].sectionObjects[indexPath.row].name
        // Configure the cell...
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if !tableData.isEmpty {
            return tableData[section].sectionName
        }
        
        return "State Not Available"
    }
    
    func refreshTable(notification: NSNotification) {
        
        print("Received Notification")
        self.tableView.reloadData()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destinationViewController as? LocationDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
                var currentloc = tableData[indexPath.section].sectionObjects[indexPath.row] as LocationModel
                destination.currentLocation = currentloc
                
            }
        }

        let vC = segue.destinationViewController as! LocationDetailViewController
        
        
    }


}
