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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

