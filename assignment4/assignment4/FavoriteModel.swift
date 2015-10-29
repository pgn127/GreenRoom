//
//  FavoriteModel.swift
//  assignment4
//
//  Created by Daniel Del Core on 29/10/2015.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import Foundation
import CoreData

@objc(Favorite)
class Favorite: NSManagedObject {
    @NSManaged var locationId: Int32
    @NSManaged var locationName: String
}
