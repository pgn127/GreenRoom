//
//  ViewController.swift
//  Assignment3
//
//  Created by Daniel Del Core on 14/10/2015.
//  Copyright (c) 2015 Daniel Del Core. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
   
    
    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet weak var searchNavButton: UIBarButtonItem!
    @IBOutlet weak var bookmarkNavButton: UIBarButtonItem!
    
    let forcastService = SurfForcastService()
    var loadComplete = false
    var stateList:[StateModel] = []
    var locationList: [LocationModel] = []
    var locationSelected: LocationModel?
    var stateLocDict = [StateModel : [LocationModel]]()
    
    
    class CustomPointAnnotation: MKPointAnnotation {
        var locationInfo: LocationModel?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMapView.delegate = self
        self.initMapView()
        self.initModels()
        

    }
    
    
    
    override func viewWillAppear(animated: Bool){
//        self.initMapView()
//        self.initModels()
        self.tabBarController?.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    
    // MARK: Main setup
    func initModels() {
        self.forcastService.getStatesAll({ (response) in
            self.stateList = response
            for state in self.stateList {
                self.forcastService.getLocationsByStateId(state.id, callback: { (locationResponse:[LocationModel]) -> () in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.locationList.appendContentsOf(locationResponse)
                        self.stateLocDict[state] = locationResponse
                        //print("\(self.stateLocDict.count)")
                        for location in locationResponse {
                            //self.stateLocDict![state] = location
                            self.addPinToMap(location.lat, long: location.long, title: location.name, locinf: location)
                        }
                        if self.stateLocDict.count == 5 {
                            self.transferInfo()
                        }
                        
                    }
                })
            }
            
        })
    }
    
    func transferInfo(){
        let barViewControllers = self.tabBarController?.viewControllers
        let nav = barViewControllers![2] as! UINavigationController
        let svc = nav.topViewController as! ListViewController
        svc.stateList = self.stateList
        svc.locationList = self.locationList
        svc.stateLocDict = self.stateLocDict

    }

    // MARK: Map view
    func initMapView() {
        let location = CLLocationCoordinate2D(latitude: -25.498321, longitude: 133.225286)
        let span = MKCoordinateSpanMake(55, 55)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mainMapView.setRegion(region, animated: true)
        
    }

    func addPinToMap(lat:Double, long:Double, title:String, subTitle:String?=nil, locinf: LocationModel) {
//        let annotation = MKPointAnnotation()
        let annotation = CustomPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = title
        annotation.subtitle = subTitle
        annotation.locationInfo = locinf
        //var anView = MKAnnotationView(annotation: annotation, reuseIdentifier: "loc")
        
        self.mainMapView.addAnnotation(annotation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
        
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myloc")
            pinAnnotationView.enabled = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.rightCalloutAccessoryView = UIButton(type: .InfoDark) as UIButton
            
            
            return pinAnnotationView
        
        
       // return nil
    }
    

    
    func mapView(MapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
        if control == annotationView.rightCalloutAccessoryView {
            if let ano = annotationView.annotation as? CustomPointAnnotation{
                self.locationSelected = ano.locationInfo
                performSegueWithIdentifier("selectedAnnotation", sender: self)
            }
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueSearch") {
            let tableVC = segue.destinationViewController as! SearchTableViewController
            tableVC.locations = NSMutableArray(array: self.locationList)
        } else if (segue.identifier == "selectedAnnotation"){
            let locVC = segue.destinationViewController as! LocationDetailViewController
            locVC.currentLocation = self.locationSelected
        }
    }
}

