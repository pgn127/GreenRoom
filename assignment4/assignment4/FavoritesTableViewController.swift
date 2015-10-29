//
//  FavoritesTableViewController.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/23/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let favoriteEntityManager: FavoriteEntityManager = FavoriteEntityManager()
    var favorites: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableData()
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item: Favorite = self.favorites[indexPath.row] as! Favorite
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("favoriteTableCell", forIndexPath: indexPath) 
        cell.textLabel!.text = item.locationName
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if (segue.identifier == "selectedAnnotation"){
//            dispatch_async(dispatch_get_main_queue(), {
//                let vc:BeachViewController = segue.destinationViewController as! BeachViewController
//                vc.model = self.beachSelected
//            })
//        }
    }
    
}
