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
    @IBOutlet weak var searchNavButton: UIBarButtonItem!
    @IBOutlet weak var bookmarkNavButton: UIBarButtonItem!
    
    let forcastService = SurfForcastService()
    var stateList:[StateModel] = []
    var locationList: [LocationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initMapView()
        self.initModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueSearch") {
            var tableVC = segue.destinationViewController as! SearchTableViewController
            tableVC.locations = NSMutableArray(array: self.locationList)
        }
    }
    
    // MARK: Main setup
    func initModels() {
        self.forcastService.getStatesAll({ (response) in
            self.stateList = response
            for state in self.stateList {
                self.forcastService.getLocationsByStateId(state.id!, callback: { (locationResponse:[LocationModel]) -> () in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.locationList.extend(locationResponse)
                        for location in locationResponse {
                            self.addPinToMap(location.lat, long: location.long, title: location.name)
                        }
                    }
                })
            }
        })
    }

    // MARK: Map view
    func initMapView() {
        let location = CLLocationCoordinate2D(latitude: -25.498321, longitude: 133.225286)
        let span = MKCoordinateSpanMake(55, 55)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mainMapView.setRegion(region, animated: true)
    }

    func addPinToMap(lat:Double, long:Double, title:String, subTitle:String?=nil) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = title
        annotation.subtitle = subTitle
        self.mainMapView.addAnnotation(annotation)
    }
}

