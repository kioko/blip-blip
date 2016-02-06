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
    
    var latitude :CLLocationDegrees!
    var longitude :CLLocationDegrees!
    
    //Difference between one side of the screen ot the other/ Zoom in
    let latDelata : CLLocationDegrees = 0.01
    let longDelata : CLLocationDegrees = 0.01
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the users location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1{
            
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        }else{ //get the location of the item the user tapped on from the tableview
            
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            
            let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelata, longDelata)
            let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let mapRegion : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            self.mapView.setRegion(mapRegion, animated: true)
            
            //Annotaion Attributes
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = places[activePlace]["name"]
            
            //add the annotation to the map
            self.mapView.addAnnotation(annotation)
        }
        
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
        self.latitude = userLocation.coordinate.latitude
        //Extract logitude
        self.longitude = userLocation.coordinate.longitude
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelata, longDelata)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        let mapRegion : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.mapView.setRegion(mapRegion, animated: true)
        self.mapView.showsUserLocation = true
        
    }
    
    //Handles the guesture action. This allows the user to add annotations to
    //the map by long pressing the map on Long press.
    func gestureAction(gestureRecognizer : UIGestureRecognizer){
        
        //check if user has long pressed
        if gestureRecognizer.state == UIGestureRecognizerState.Began{
            
            //Get the location of where the user has long pressed
            let touchPoint = gestureRecognizer.locationInView(self.mapView)
            
            //convert the touch point to coordinates
            let location : CLLocationCoordinate2D = mapView.convertPoint(touchPoint,
                toCoordinateFromView: self.mapView)
            
            let locationCoordinate = CLLocation(latitude: location.latitude, longitude: location.longitude)
            
            CLGeocoder().reverseGeocodeLocation(locationCoordinate, completionHandler: {(placeMarks, errors) -> Void in
                
                var title:String = ""
                var country:String = ""
                var thoroughfare:String = ""
                var subThoroughfare:String = ""
                
                if(errors != nil){
                    print(errors)
                }else{
                    
                    //Check if placeMarks contains data
                    if let placeMark = placeMarks?[0] {
                        
                        if placeMark.thoroughfare != nil{
                            thoroughfare = placeMark.thoroughfare!
                        }
                        
                        if placeMark.subThoroughfare != nil{
                            subThoroughfare = placeMark.subThoroughfare!
                        }
                        
                        if placeMark.country != nil{
                            country = placeMark.country!
                        }
                        
                        title = "\(subThoroughfare) - \(thoroughfare)"
                        
                        //Append place information to Place array
                        places.append(["name":title, "lat":"\(location.latitude)",
                            "lon": "\(location.longitude)"])
                        
                        //Annotaion Attributes
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = title
                        annotation.subtitle = country
                        
                        //add the annotation to the map
                        self.mapView.addAnnotation(annotation)
                    }
                }
            })
        }
    }
}

