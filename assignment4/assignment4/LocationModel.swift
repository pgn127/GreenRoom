//
//  LocationModel.swift
//  Assignment3
//
//  Created by Daniel Del Core on 19/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import Foundation

class LocationModel : NSObject, CustomDebugStringConvertible {
    
    var id: Int
    var name: String
    var stateId: Int
    var lat: Double
    var long: Double
    

    override var description: String {
        return "id: " + String(stringInterpolationSegment: self.id) + "\n" +
            "name: " + String(stringInterpolationSegment: self.name) + "\n" +
            "stateId: " + String(stringInterpolationSegment: self.stateId) + "\n" +
            "lat: " + String(stringInterpolationSegment: self.lat) + "\n" +
            "long: " + String(stringInterpolationSegment: self.long)
    }
    
    override var debugDescription: String {
        return "DEBUG: id: " + String(stringInterpolationSegment: self.id) + "\n" +
            "name: " + String(stringInterpolationSegment: self.name) + "\n" +
            "stateId: " + String(stringInterpolationSegment: self.stateId) + "\n" +
            "lat: " + String(stringInterpolationSegment: self.lat) + "\n" +
            "long: " + String(stringInterpolationSegment: self.long)
    }
    
    init (id: Int, name: String, stateId: Int, lat:Double, long: Double) {
        self.id = id
        self.name = name
        self.stateId = stateId
        self.lat = lat
        self.long = long
    }
    
    // Returns the geo-location for this location
    func getLocation() -> (lat: Double, long: Double) {
        return (self.lat, self.long)
    }
}