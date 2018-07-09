//
//  MapViewController.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 17.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addAreaOptionsStackView: UIStackView!
    private let regionRadius: CLLocationDistance = 3000
    private let location = CLLocation(latitude: 49.9667396, longitude: 7.9045959999999695)
    @IBAction func logoutBtn(_ sender: Any) {
         performSegue(withIdentifier: "segueLogout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: location)
   
    }
    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.mapView)
        let coordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
    }
    
   
    
 
    @IBAction func addArea(_ sender: Any) {
        addAreaOptionsStackView.isHidden = false
    }
    
    @IBAction func undoPoint(_ sender: Any) {
    }
    
    @IBAction func saveNewArea(_ sender: Any) {
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
