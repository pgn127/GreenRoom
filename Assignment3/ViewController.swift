//
//  ViewController.swift
//  Assignment3
//
//  Created by Daniel Del Core on 14/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mainMapView: MKMapView!
    
    var forcastService = SurfForcastService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forcastService.getStatesAll()
        self.forcastService.getStatesById(5)
        self.forcastService.getLocationById(14)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

