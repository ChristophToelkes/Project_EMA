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

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addAreaOptionsStackView: UIStackView!
    @IBOutlet weak var addNewArea: UIButton!
    private let regionRadius: CLLocationDistance = 3000
    private let location = CLLocation(latitude: 49.9667396, longitude: 7.9045959999999695)
    private var addPoinsEnabled = false
    private var points = [MKPointAnnotation]()
    private var points2D = [CLLocationCoordinate2D]()
    
    @IBAction func logoutBtn(_ sender: Any) {
         performSegue(withIdentifier: "segueLogout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: location)
   
    }
    
    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        if(addPoinsEnabled && sender.state == UIGestureRecognizerState.began){
            let location = sender.location(in: self.mapView)
            let coordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            self.mapView.addAnnotation(annotation)
            points.append(annotation)
            points2D.append(coordinate)
            if(points.count > 2){
                addNewArea.isEnabled = true
            }
            
        }
    }

    @IBAction func addArea(_ sender: Any) {
        addAreaOptionsStackView.isHidden = false
        addPoinsEnabled = true
    }
    
    @IBAction func undoPoint(_ sender: Any) {
        guard let p = points.popLast() else {
            return
        }
        _ = points2D.popLast()
        mapView.removeAnnotation(p)
        if(points.count < 3){
            addNewArea.isEnabled = false
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // alle felder aus der datenbank lesen und in mapView eintragen
    }
 
    
    @IBAction func saveNewArea(_ sender: Any) {
        mapView.delegate = self
        let polygon =  points2D.map{_ in MKPolygon(coordinates: points2D, count: points.count)}
     
        mapView.addOverlays(polygon)
        mapView.removeAnnotations(mapView.annotations)
        
        
        // mit alert noch den Namen des Feldes eintragen lassen
        // inhalt von points[] und namen des Feldes  in datenbank abspeichern
        
        
    
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      
            
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 3
            return renderer
            
        } else if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.fillColor = UIColor.green.withAlphaComponent(0.1)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    
    
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

    
}


