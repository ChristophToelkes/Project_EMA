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

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addAreaOptionsStackView: UIStackView!
    @IBOutlet weak var addAreaOptionsStackView2: UIStackView!
    
    @IBOutlet weak var tableViewAreas: UITableView!
    @IBOutlet weak var addAreaTextField: UITextField!
    @IBOutlet weak var addNewArea: UIButton!
    private let regionRadius: CLLocationDistance = 3000
    private let location = CLLocation(latitude: 49.9667396, longitude: 7.9045959999999695)
    private var addPoinsEnabled = false
    private var points = [MKPointAnnotation]()
    private var points2D = [CLLocationCoordinate2D]()
    private var areas = [Area]()
    private let fader = ViewFader.init()
    private var showTableView = false
    
    @IBAction func logoutBtn(_ sender: Any) {
         performSegue(withIdentifier: "segueLogout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: location)
        tableViewAreas.delegate = self
        tableViewAreas.dataSource = self
        
        
   
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
        if(!addPoinsEnabled){
            fader.fade(mode: ViewFader.FadeMode.IN, view: self.addAreaOptionsStackView)
            fader.fade(mode: ViewFader.FadeMode.IN, view: self.addAreaOptionsStackView2)
            addPoinsEnabled = true
        } else {
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.addAreaOptionsStackView)
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.addAreaOptionsStackView2)
            addPoinsEnabled = false
        }
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
        
        

      
        
        let alert = UIAlertController(title: "Neues Feld speichern?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "speichern", style: .default, handler: { (nil) in
            
       
            
              // inhalt von points[] und namen des Feldes  in datenbank abspeichern
            
            self.areas.append(Area.init(name: self.addAreaTextField.text!, points: self.points2D))
            self.tableViewAreas.reloadData()
            
            
            
            self.addAreaOptionsStackView.isHidden = true
            self.addAreaOptionsStackView2.isHidden = true
            self.addPoinsEnabled = false
            self.points2D = []
            self.points = []
        }))
        alert.addAction(UIAlertAction(title: "zurück", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        
  
        
    
    }
    
    @IBAction func showAllFAreasBtn(_ sender: Any) {
        if(!showTableView){
            fader.fade(mode: ViewFader.FadeMode.IN, view: tableViewAreas)
            showTableView = true
        } else {
            fader.fade(mode: ViewFader.FadeMode.OUT, view: tableViewAreas)
            showTableView = false
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      
            
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 3
            return renderer
            
        } else if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.fillColor = UIColor.purple.withAlphaComponent(0.1)
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
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = areas[indexPath.row].name
 
        cell?.contentView.sizeToFit()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("nur kurz")
        guard let areaFirstPoint = areas[indexPath.row].points.first else {return}
        centerMapOnLocation(location: CLLocation.init(latitude: areaFirstPoint.latitude, longitude: areaFirstPoint.longitude))
       
       
    }
    
 
    
    
    
    @IBAction func longPressDeleteArea(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
              print("lange")
            
            let touchPoint = sender.location(in: self.tableViewAreas)
            if let indexPath = tableViewAreas.indexPathForRow(at: touchPoint) {
              
                areas.remove(at: indexPath.row)
                print(indexPath.row)
                self.tableViewAreas.reloadData()
                
            }
            
            
                
            
    }
    
    
    
}


}
