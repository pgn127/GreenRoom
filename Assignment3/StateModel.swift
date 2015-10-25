//
//  StateModel.swift
//  Assignment3
//
//  Created by Daniel Del Core on 19/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import Foundation

func ==(lhs: StateModel, rhs: StateModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

class StateModel : NSObject, CustomDebugStringConvertible {
    
    var id: Int
    var name: String
    override var hashValue: Int {
        return self.id
    }
//    var locations: [LocationModel]?
    
    override var description: String {
        return "id: " + String(stringInterpolationSegment: self.id) + "\n" +
            "name: " + String(stringInterpolationSegment: self.name)
    }
    
    override var debugDescription: String {
        return "DEBUG: id: " + String(stringInterpolationSegment: self.id) + "\n" +
            "name: " + String(stringInterpolationSegment: self.name)
    }
    
    init (id: Int, name: String) {
        self.id = id
        self.name = name
//        self.locations = locations
    }

}
