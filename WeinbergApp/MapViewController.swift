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
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addAreaOptionsStackView: UIStackView!
    @IBOutlet weak var addAreaOptionsStackView2: UIStackView!
    
    @IBOutlet weak var tableViewAreas: UITableView!
    @IBOutlet weak var addAreaTextField: UITextField!
    @IBOutlet weak var addNewArea: UIButton!
    @IBOutlet weak var showAllAreasBtn: UIButton!
    @IBOutlet weak var removerPinBtn: UIButton!
   
    @IBOutlet weak var sizeAreaTextField: UILabel!
    
    private let location = CLLocation(latitude: 49.9667396, longitude: 7.9045959999999695)
    private var points = [MKPointAnnotation]()
    private var points2D = [CLLocationCoordinate2D]()
    private var areas = [Area]()
    private let fader = ViewFader.init()
    private var entryList = [Entry]()
    private var addPoinsEnabled = false
    private var showTableView = false
    public var mapLoaded = false
    private let borderColor = UIColor.lightGray.cgColor
    private let locationManager = CLLocationManager()

    
    
    /// Setzt Constraints und fordert die gespeicherten Areale an.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewAreas.delegate = self
        tableViewAreas.dataSource = self
        mapView.delegate = self
        
        addAreaTextField.layer.borderColor = borderColor
        addNewArea.layer.borderColor = borderColor
        removerPinBtn.layer.borderColor = borderColor
        
        addAreaTextField.layer.borderWidth = 1
        addNewArea.layer.borderWidth = 1
        removerPinBtn.layer.borderWidth = 1
        
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
     
        addAreaOptionsStackView2.sendSubview(toBack: addAreaOptionsStackView)
        if(mapLoaded){
            loadAreasFromRealm()
        }
    }
    
    /// Zentralisiert die MapView auf einem angegebenen Punkt.
    ///
    /// - Parameters:
    ///   - manager: Der LocationManager
    ///   - locations: Der Punkt, auf dem zentralisiert wird
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        centerMapOnLocation(location: CLLocation(latitude: locValue.latitude, longitude: locValue.longitude), dist: 1000)
    }
    
    
    
    /// Fordert die gespeicherten Areale an.
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        loadAreasFromRealm()
    }
    
    /// Leitet den Nutzer zum LogIn Bildschirm
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func logoutBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueLogout", sender: self)
    }
    
    /// Fügt Eckpunkte für die Arealmarkierung auf der Karte ein.
    /// Ermöglicht das Speichern eines Areals ab 3 Punkten.
    /// - Parameter sender: Der auf der Karte gedrückte Punkt
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

    /// Zeigt ein Areal an oder blendet es aus.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func addArea(_ sender: Any) {
        if(!addPoinsEnabled){
            fader.fade(mode: ViewFader.FadeMode.IN, view: self.addAreaOptionsStackView)
            fader.fade(mode: ViewFader.FadeMode.IN, view: self.addAreaOptionsStackView2)
            addPoinsEnabled = true
        } else {
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.addAreaOptionsStackView)
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.addAreaOptionsStackView2)
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.tableViewAreas)
            addPoinsEnabled = false
            showTableView = false
            
        }
    }
    
    /// Entfernt einen Eckpunkt von der Karte.
    /// Deaktiviert das Speichern eines Areals, bei weniger als 3 Eckpunkten.
    /// - Parameter sender: Der gedrückte Punkt
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
    
    /// Fordert Areale an und setzt das mapLoaded Flag.
    ///
    /// - Parameter mapView: Die angezeigte MapView
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        loadAreasFromRealm()
        mapLoaded = true
    }
    
    /// Lädt die gespeicherten Areale aus der Datenbank.
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
 
    
    /// Ermöglicht die Speicherung eines eingezeichneten Areals in der Datenbank.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func saveNewArea(_ sender: Any) {
        
        let polygon =  self.points2D.map{_ in MKPolygon(coordinates: self.points2D, count: self.points2D.count)}
        self.mapView.addOverlays(polygon)
        self.mapView.removeAnnotations(self.mapView.annotations)
  
        let alert = UIAlertController(title: "Neues Feld speichern?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "speichern", style: .default, handler: { (nil) in
           
            var pointsString = ""
            self.points2D.forEach({ (e) in
                let coordinate: String = e.latitude.description+":"+e.longitude.description+" " // Punkte werden in Form "lat1:long1 lat2:long2 "... 
                pointsString.append(coordinate)
            })
            
            let db = RealmHelper()
            db.addArea(areaName: self.addAreaTextField.text!, points: pointsString, captureType: "Area", size: "\(self.areaSize(points: self.points2D))")
          
            
           
            self.tableViewAreas.reloadData()
            self.loadAreasFromRealm()
            
            self.addAreaOptionsStackView.isHidden = true
            self.addAreaOptionsStackView2.isHidden = true
            self.addPoinsEnabled = false
            self.addNewArea.isEnabled = false
            self.points2D = []
            self.points = []
        }))
        alert.addAction(UIAlertAction(title: "zurück", style: .default, handler: { (nil) in
        
            self.tableViewAreas.reloadData()
            self.loadAreasFromRealm()
            self.addNewArea.isEnabled = false
            self.points2D = []
            self.points = []
        }))
        self.present(alert, animated: true)
    }
    
    /// Zeigt alle gespeicherten Areale an oder blendet sie aus.
    ///
    /// - Parameter sender: Der gedrückte Button
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
    
    /// Gibt den entsprechenden Renderer zurück, zum zeichnen der Areale.
    ///
    /// - Parameters:
    ///   - mapView: Die MapView, auf der gezeichnet wird
    ///   - overlay: Die Art, was gezeichnet werden soll
    /// - Returns: Der Renderer
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
    
    /// Positioniert die Map auf einem Punkt.
    ///
    /// - Parameters:
    ///   - location: Der Punkt, auf dem positioniert werden soll.
    ///   - dist: Die Zoomstufe
    private func centerMapOnLocation(location: CLLocation, dist: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, dist, dist)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        cell?.textLabel?.text = entryList[indexPath.row].areaName! + " " + entryList[indexPath.row].areaSize! + "qm"
        cell?.contentView.sizeToFit()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        guard let areaPoints = entryList[indexPath.row].points else {return}
        let latFirstPoint = areaPoints.split(separator: " ")[0].split(separator: ":")[0]
        let longFirstPoint = areaPoints.split(separator: " ")[0].split(separator: ":")[1]
        
        let latThirdPoint = areaPoints.split(separator: " ")[2].split(separator: ":")[0]
        let longThirdPoint = areaPoints.split(separator: " ")[2].split(separator: ":")[1]
        
        let areaCenterLat = ((latFirstPoint as NSString).doubleValue + (latThirdPoint as NSString).doubleValue) / 2
        let areaCenterLong = ((longFirstPoint as NSString).doubleValue + (longThirdPoint as NSString).doubleValue) / 2
        
        centerMapOnLocation(location: CLLocation.init(latitude: areaCenterLat-0.00045, longitude: areaCenterLong), dist: 500) // -0.00045 : um das gewählte Feld über die TabelView zu heben
    }
    /// Entfernt ein Areal aus der Datenbank.
    ///
    /// - Parameter sender: Der gedrückte Button.
    @IBAction func deleteAreaLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            
            print("dvewvw")
            let touchPoint = sender.location(in: self.tableViewAreas)
            if let indexPath = tableViewAreas.indexPathForRow(at: touchPoint) {
                guard let area = entryList[indexPath.row].areaName else {return}
                print("dvewvw")
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
    
    @IBAction func tapOnMapView(_ sender: UITapGestureRecognizer) {
        if(showTableView){
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.tableViewAreas)
            showTableView = false
            return
        }
        if(points2D.count == 0){
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.addAreaOptionsStackView)
            fader.fade(mode: ViewFader.FadeMode.OUT, view: self.addAreaOptionsStackView2)
            addPoinsEnabled = false
        }
    }
    
    private func areaSize(points: [CLLocationCoordinate2D]) -> Int{
        var temp: Double = 0
        var temp2: Double = 0
        var result: Double = 0
        var points2 = points
        
        
        for i in 0...points.count-1 {
            points2[i].latitude = points2[i].latitude * (Double.pi * 6378137 / 180)
            points2[i].longitude = points2[i].longitude * (Double.pi * 6378137 / 180)
        }
       
        for i in 0...points2.count-2 {
            temp += points2[i].latitude * points2[i+1].longitude
        }
        temp += points2[points2.count-1].latitude * points2[0].longitude
        for i in 0...points2.count-2 {
            temp2 += points2[i].longitude * points2[i+1].latitude
        }
        temp2 += points2[points2.count-1].longitude * points2[0].latitude
        result = temp - temp2
     
        return abs(Int(result / 2))
    }
    
    
    
}
