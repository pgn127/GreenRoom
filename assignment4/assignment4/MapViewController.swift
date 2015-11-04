//
//  ViewController.swift
//  Assignment3
//
//  Created by Daniel Del Core on 14/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var locationInfo: LocationModel?
}

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mainMapView: MKMapView!

    let forcastService = SurfForcastService()
    var stateList: [StateModel] = []
    var locationList: [LocationModel] = []
    var beachSelected: BeachModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        mainMapView.delegate = self
        
        self.initViewController()
    }

    override func viewWillAppear(animated: Bool){

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initViewController() {
        if Reachability.isConnectedToNetwork() == true {
            // Internet connection OK
            
            self.initMapView()
            self.initModels()
            
        } else {
            print("Internet connection FAILED")
            //alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            let resetAction = UIAlertAction(title: "Retry", style: .Default) { (action) in
                self.initViewController()
            }
            alertController.addAction(resetAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    // MARK: Main setup
    func initModels() {
        self.forcastService.getStatesAll({ (response) in
            self.stateList = response
            for state in self.stateList {
                self.forcastService.getLocationsByStateId(state.id, callback: { (locationResponse:[LocationModel]) -> () in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.locationList.appendContentsOf(locationResponse)
                        for location in locationResponse {
                            self.addPinToMap(location.lat, long: location.long, title: location.name, locinf: location)
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

    func addPinToMap(lat:Double, long:Double, title:String, subTitle:String?=nil, locinf: LocationModel) {
        let annotation = CustomPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = title
        annotation.subtitle = subTitle
        annotation.locationInfo = locinf
        self.mainMapView.addAnnotation(annotation)
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myloc")
        pinAnnotationView.enabled = true
        pinAnnotationView.canShowCallout = true
        pinAnnotationView.animatesDrop = true
        pinAnnotationView.rightCalloutAccessoryView = UIButton(type: .InfoDark) as UIButton
        return pinAnnotationView
    }

    func mapView(MapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
            if let ano = annotationView.annotation as? CustomPointAnnotation{
                self.forcastService.getLocationById((ano.locationInfo?.id)!, callback: { (response:BeachModel) -> () in
                    self.beachSelected = response
                    self.performSegueWithIdentifier("selectedAnnotation", sender: self)
                })
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "selectedAnnotation"){
            dispatch_async(dispatch_get_main_queue(), {
                let vc:BeachViewController = segue.destinationViewController as! BeachViewController
                vc.model = self.beachSelected
            })
        }
    }
}
