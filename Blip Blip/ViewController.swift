//
//  ViewController.swift
//  Blip Blip
//
//  Created by Kioko on 05/02/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //Handles the guesture action. This allows the user to add annotations to 
    // the map by long pressing the map on Long press.
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

