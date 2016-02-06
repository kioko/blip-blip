//
//  ViewController.swift
//  Blip Blip
//
//  Created by Kioko on 05/02/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the users location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let latitude :CLLocationDegrees = -1.2921
        let longitude :CLLocationDegrees = 36.8219
        
        
        //Difference between one side of the screen ot the other/ Zoom in
        let latDelata : CLLocationDegrees = 0.01
        let longDelata : CLLocationDegrees = 0.01
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelata, longDelata)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let mapRegion : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(mapRegion, animated: true)
        
        //Add annotations
        let annotation = MKPointAnnotation()
        
        //Annotaion Attributes
        annotation.coordinate = location
        annotation.title = "Ihub"
        annotation.subtitle = "The Geek Dome"
        
        //add the annotation to the map
        mapView.addAnnotation(annotation)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "gestureAction:")
        
        //set the minimum press duration in secs
        longPressGesture.minimumPressDuration = 2
        
        //Add the guesture to the map
        mapView.addGestureRecognizer(longPressGesture)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This method is called when the users location changes
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //convert the location to CLLocation
        let userLocation : CLLocation = locations[0] as CLLocation
        
        //Extract latitude
        let latitude = userLocation.coordinate.latitude
        //Extract logitude
        let longitude = userLocation.coordinate.longitude
        
        //Difference between one side of the screen ot the other/ Zoom in
        let latDelata : CLLocationDegrees = 0.01
        let longDelata : CLLocationDegrees = 0.01
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelata, longDelata)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let mapRegion : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.mapView.setRegion(mapRegion, animated: true)
        
        
    }
    
    //Handles the guesture action. This allows the user to add annotations to
    //the map by long pressing the map on Long press.
    func gestureAction(gestureRecognizer : UIGestureRecognizer){
        
        //Get the location of where the user has long pressed
        let touchPoint = gestureRecognizer.locationInView(self.mapView)
        
        //convert the touch point to coordinates
        let location : CLLocationCoordinate2D = mapView.convertPoint(touchPoint,
            toCoordinateFromView: self.mapView)
        
        //Add the annotation to the map
        let annotation = MKPointAnnotation()
        
        //Annotaion Attributes
        annotation.coordinate = location
        annotation.title = "Blip"
        annotation.subtitle = "New location"
        
        //add the annotation to the map
        mapView.addAnnotation(annotation)
    }
    
    
}

