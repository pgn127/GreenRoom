//
//  FavoritesTableViewController.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/23/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let forcastService = SurfForcastService()
    let favoriteEntityManager: FavoriteEntityManager = FavoriteEntityManager()
    var favorites: NSMutableArray = []
    var beachSelected: BeachModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewController()
    }
    
    func initViewController() {
        if Reachability.isConnectedToNetwork() == true {
            // Internet connection OK
            self.loadTableData()
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
        return self.favorites.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomTableViewCell {
        let item: Favorite = self.favorites[indexPath.row] as! Favorite
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("favoriteTableCell", forIndexPath: indexPath) as! CustomTableViewCell
        cell.textLabel!.text = item.locationName
        cell.locationId = Int(item.locationId)
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let deletedRowName:Favorite = self.favorites[indexPath.row] as! Favorite
            self.favoriteEntityManager.deleteFavorites(deletedRowName.locationName)
            self.favoriteEntityManager.saveAction()
            self.loadTableData()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    func loadTableData() {
        // Cast and order the Collections array
        var favoritesMutable = NSMutableArray(array: self.favoriteEntityManager.getAllFavorites())
        favoritesMutable = NSMutableArray(array: favoritesMutable.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
        self.favorites = favoritesMutable
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as! CustomTableViewCell
        
        self.forcastService.getLocationById((currentCell.locationId)!, callback: { (response:BeachModel) -> () in
            self.beachSelected = response
            self.performSegueWithIdentifier("favoriteSegue", sender: self)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print(segue)
        if (segue.identifier == "favoriteSegue") {
            dispatch_async(dispatch_get_main_queue(), {
                let vc:BeachViewController = segue.destinationViewController as! BeachViewController
                vc.model = self.beachSelected
            })
        }
    }
    
}
