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
import RealmSwift

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addAreaOptionsStackView: UIStackView!
    @IBOutlet weak var addAreaOptionsStackView2: UIStackView!
    
    @IBOutlet weak var tableViewAreas: UITableView!
    @IBOutlet weak var addAreaTextField: UITextField!
    @IBOutlet weak var addNewArea: UIButton!

    private let location = CLLocation(latitude: 49.9667396, longitude: 7.9045959999999695)
    private var addPoinsEnabled = false
    private var points = [MKPointAnnotation]()
    private var points2D = [CLLocationCoordinate2D]()
    private var areas = [Area]()
    private let fader = ViewFader.init()
    private var showTableView = false
    private var entryList = [Entry]()
    private var mapLoaded = false
    
    @IBAction func logoutBtn(_ sender: Any) {
         performSegue(withIdentifier: "segueLogout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: location, dist: 2000)
        tableViewAreas.delegate = self
        tableViewAreas.dataSource = self
        mapView.delegate = self
        if(mapLoaded){
            loadAreasFromRealm()
        }
        
        
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
        loadAreasFromRealm()
        mapLoaded = true
    }
    
    private func loadAreasFromRealm(){
        entryList = []
        let db = RealmHelper()
        entryList = db.loadObjects(type: "Area")
     
        self.mapView.removeOverlays(self.mapView.overlays)
        entryList.forEach { (entry) in
            let pointsString = entry.points
            
            guard let pointsStringArray = pointsString?.split(separator: " ") else {return}
            var points2D = [CLLocationCoordinate2D]()
            
            pointsStringArray.forEach({ (e) in
               
                let latitude = e.split(separator: ":")[0]
                let longitude = e.split(separator: ":")[1]
                points2D.append(CLLocationCoordinate2D(latitude: (latitude as NSString).doubleValue, longitude: (longitude as NSString).doubleValue))
                
            })
            let polygon = points2D.map{_ in MKPolygon(coordinates: points2D, count: points2D.count)}
            points2D = []
            mapView.addOverlays(polygon)
        }
        tableViewAreas.reloadData()
    }
 
    
    @IBAction func saveNewArea(_ sender: Any) {
        
        let polygon =  self.points2D.map{_ in MKPolygon(coordinates: self.points2D, count: self.points2D.count)}
        self.mapView.addOverlays(polygon)
        self.mapView.removeAnnotations(self.mapView.annotations)
  
        let alert = UIAlertController(title: "Neues Feld speichern?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "speichern", style: .default, handler: { (nil) in
           
            var pointsString = ""
            self.points2D.forEach({ (e) in
                let coordinate: String = e.latitude.description+":"+e.longitude.description+" "
                pointsString.append(coordinate)
            })
            
            let db = RealmHelper()
            db.addArea(areaName: self.addAreaTextField.text!, points: pointsString, captureType: "Area")
          
            
           
            self.tableViewAreas.reloadData()
            self.loadAreasFromRealm()
            
            
            self.addAreaOptionsStackView.isHidden = true
            self.addAreaOptionsStackView2.isHidden = true
            self.addPoinsEnabled = false
            self.addNewArea.isEnabled = false
            self.points2D = []
            self.points = []
        }))
        alert.addAction(UIAlertAction(title: "zurück", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        
  
        
    
    }
    
    @IBAction func showAllFAreasBtn(_ sender: Any) {
        if(!showTableView){
            self.tableViewAreas.reloadData()
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
    
    private func centerMapOnLocation(location: CLLocation, dist: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, dist, dist)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = entryList[indexPath.row].areaName
        cell?.contentView.sizeToFit()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        guard let areaFirstPoint = entryList[indexPath.row].points else {return}
        let lat = areaFirstPoint.split(separator: " ")[0].split(separator: ":")[0]
        let long = areaFirstPoint.split(separator: " ")[0].split(separator: ":")[1]
        centerMapOnLocation(location: CLLocation.init(latitude: (lat as NSString).doubleValue, longitude: (long as NSString).doubleValue), dist: 500)
    }

    @IBAction func longPressDeleteArea(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {

            
            let touchPoint = sender.location(in: self.tableViewAreas)
            if let indexPath = tableViewAreas.indexPathForRow(at: touchPoint) {
    
                
            
                guard let area = entryList[indexPath.row].areaName else {return}
                let alert = UIAlertController(title: "Feld "+area + " löschen?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "löschen", style: .default, handler: { (nil) in
                let db = RealmHelper()
                db.deleteArea(entry: self.entryList[indexPath.row])
                self.loadAreasFromRealm()
            }))
            alert.addAction(UIAlertAction(title: "zurück", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            }
            
                
            
    }
    
    
    
}


}
