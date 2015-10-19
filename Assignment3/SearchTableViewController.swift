//
//  SearchTableViewController.swift
//  Assignment3
//
//  Created by Daniel Del Core on 19/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var locations: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //println(self.locations)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item: LocationModel = self.locations[indexPath.row] as! LocationModel
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "UITableViewCell")
        
        cell.textLabel!.text = item.name
//        cell.detailTextLabel!.text = item.id
        
        return cell
    }
}