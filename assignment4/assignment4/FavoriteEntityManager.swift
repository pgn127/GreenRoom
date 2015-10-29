//
//  FavoriteEntityManager.swift
//  assignment4
//
//  Created by Daniel Del Core on 29/10/2015.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit
import CoreData

class FavoriteEntityManager {
    
    // Get a reference to the NSManagedObjectContext:
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    /**
        Favorites Methods
     */
    
    func createFavorite (id:Int32, name:String) {
        let entity =  NSEntityDescription.entityForName("Favorite", inManagedObjectContext: self.managedObjectContext)
        let favorite = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext) as! Favorite
        favorite.locationId = id
        favorite.locationName = name
        
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func getAllFavorites () -> [Favorite] {
        let fetchRequest = NSFetchRequest(entityName: "Favorite")
        var fetchedResults: [Favorite] = []
        
        do {
            fetchedResults = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Favorite]
        } catch let error as NSError  {
            print(error, "Could not fetch \(error)")
        }
        
        return fetchedResults
    }
    
    func deleteFavorites (rowName:String) {
        var fetchedResults = self.getGetByName(rowName)
        
        if !fetchedResults.isEmpty {
            self.managedObjectContext.deleteObject(fetchedResults[0])
        } else {
            print("Collection of the name \(rowName) was not deleted.")
        }
    }
    
    func getGetByName(name:String) -> [Favorite] {
        var fetchedResults: [Favorite] = []
        let fetchRequest = NSFetchRequest(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "locationName CONTAINS[c] %@", name)
        
        do {
            try fetchedResults = self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Favorite]
        } catch let error as NSError  {
            print("Could not fetch Collection \(error), \(error.userInfo)")
        }
        
        return fetchedResults
    }
    
    func saveAction() {
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}