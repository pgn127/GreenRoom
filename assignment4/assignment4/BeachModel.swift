//
//  BeachModel.swift
//  assignment4
//
//  Created by Daniel Del Core on 28/10/2015.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import Foundation

struct Forcast {
    var day:String
    var hour: String
    var swellDirection: String
    var swellDirectionDeg: Int
    var swellHeightMetres: String
    var swellPeriod: Int
    var windDirection: String
    var windDirectionDeg: Int
    var windSpeed: String
}

class BeachModel : CustomStringConvertible, CustomDebugStringConvertible {
    var id: Int!
    var name: String!
    var slug: String!
    var lat: String!
    var long: String!
    var forcastArray: [Forcast]!

    init () {

    }

    init (id: Int, name: String, slug: String, lat: String, long: String, forcastArray: [Forcast]) {
        self.id = id
        self.name = name
        self.slug = slug
        self.lat = lat
        self.long = long
        self.forcastArray = forcastArray
    }

    var description: String {
        return "id: " + String(stringInterpolationSegment: self.id) + "\n" +
            "name: " + String(stringInterpolationSegment: self.name)
    }

    var debugDescription: String {
        return "DEBUG: id: " + String(stringInterpolationSegment: self.id) + "\n" +
            "name: " + String(stringInterpolationSegment: self.name)
    }
}
