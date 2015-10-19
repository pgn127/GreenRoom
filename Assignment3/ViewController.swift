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
    
    let forcastService = SurfForcastService()
    var stateList:[StateModel] = []
    //var locationList: [LocationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initModels()
        self.initMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: Main setup
    func initModels() {
        self.forcastService.getStatesAll({ (response) in
            self.stateList = response
        })
        
        self.forcastService.getStatesById(5)
        //        self.forcastService.getLocationById(14)
        
    }

    // MARK: Map view
    func initMapView() {

        let location = CLLocationCoordinate2D(
            latitude: 51.50007773,
            longitude: -0.1246402
        )

        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mainMapView.setRegion(region, animated: true)
        

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        self.mainMapView.addAnnotation(annotation)
    }

}

