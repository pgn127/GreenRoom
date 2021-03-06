//
//  StateModel.swift
//  Assignment3
//
//  Created by Daniel Del Core on 19/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import Foundation

class StateModel : CustomStringConvertible, CustomDebugStringConvertible {
    var id: Int
    var name: String

    init (id: Int, name: String) {
        self.id = id
        self.name = name
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
