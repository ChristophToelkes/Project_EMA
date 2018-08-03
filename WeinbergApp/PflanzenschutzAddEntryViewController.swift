//
//  PflanzenschutzAddEntryViewController.swift
//  WeinbergApp
//
//  Created by ema on 27.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class PflanzenschutzAddEntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var entry: Entry?
    var captureType: String?
    var areas = [String]()
    var category = ""
    @IBOutlet weak var headCaptureLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
 
    @IBOutlet weak var contentView: UIView!
 
    @IBOutlet weak var fungicideButton: UIButton!
    @IBOutlet weak var herbicideButton: UIButton!
    @IBOutlet weak var insecticideButton: UIButton!
    @IBOutlet weak var areaPicker: UIPickerView!
    @IBOutlet weak var benutzerText: UITextField!
    @IBOutlet weak var arbeitszeitText: UITextField!
    @IBOutlet weak var gegenText: UITextField!
    @IBOutlet weak var mittelText: UITextField!
    @IBOutlet weak var terminText: UITextField!
    @IBOutlet weak var infoText: UITextField!
    @IBOutlet weak var mengePflanzenschutzmittelText: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// Zeigt den zuvor gewählten Eintrag an oder legt einen neuen Eintrag an.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.areaPicker.delegate = self
        self.areaPicker.dataSource = self
      
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 340, height: 2000)
        headCaptureLabel.text = captureType
        loadAreasFromRealm()
        if let entry = entry {
            captureType = entry.getCaptureType()
            headCaptureLabel.text =  entry.getCaptureType()
        
            benutzerText.text = entry.getUser()
            arbeitszeitText.text = entry.getHours()
            gegenText.text = entry.getGegen()
            mittelText.text = entry.getMittel()
            terminText.text = entry.getTermin()
            infoText.text = entry.getInfo()
            mengePflanzenschutzmittelText.text = entry.getMengePflanzenschutzmittel()
            category = entry.getCategory()
            
            if(category == "Fungizid"){
                fungicideButton.backgroundColor = UIColor.gray
                herbicideButton.backgroundColor = UIColor.white
                insecticideButton.backgroundColor = UIColor.white
            }
            if(category == "Herbizid"){
                fungicideButton.backgroundColor = UIColor.white
                herbicideButton.backgroundColor = UIColor.gray
                insecticideButton.backgroundColor = UIColor.white
            }
            if(category == "Insektizid/Akarizid"){
                fungicideButton.backgroundColor = UIColor.white
                herbicideButton.backgroundColor = UIColor.white
                insecticideButton.backgroundColor = UIColor.gray
                
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: entry.getDate()){
                datePicker.date = date
            }
            if (entry.getField().characters.count > 0){
                areaPicker.selectRow(areas.index(of: entry.getField())!, inComponent: 0, animated: true)
                
            }
        }
    }
    
    //Es gibt bisher keine Fehlermeldung bei unvollständigem Ausfüllen
    /// Speichert den Eintrag in der Datenbank, falls sämtliche Felder ausgefüllt sind.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func safeEntryBtn(_ sender: Any) {
        let db = RealmHelper()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: datePicker.date)
        
        if captureType != nil && areas.count > 0 && benutzerText.text != nil && arbeitszeitText.text != nil && gegenText.text != nil && mittelText.text != nil && terminText.text != nil && infoText.text != nil && mengePflanzenschutzmittelText.text != nil && arbeitszeitText.text != nil && mengePflanzenschutzmittelText.text != nil{
            db.addPflanzenschutz(captureType: captureType!, benutzer: benutzerText.text!, feld: areas[areaPicker.selectedRow(inComponent: 0)], arbeitszeit: arbeitszeitText.text!, datum: date, gegen: gegenText.text!, mittel: mittelText.text!, termin: terminText.text!, info: infoText.text!, mengePflanzenschutzmittel: mengePflanzenschutzmittelText.text!, category: category)
        }
    }
    
    /// Leitet den Nutzer zur Übersicht über die gespeicherten Einträge des Arbeitsvorgangs oder Aufwands weiter.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        
    }
    
    /// Fragt den Nutzer, ob der angezeigt Eintrag gelöscht werden soll.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func pressDeleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Eintrag löschen", message: "Möchten Sie diesen Eintrag wirklich löschen?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { (nil) in
            self.deleteEntry()
        }))
        alert.addAction(UIAlertAction(title: "Nein", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /// Ändert die Pflanzenschutzmittel-Kategorie zu "Fungizid" und hebt den entsprechenden Button hervor.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func pressFungicide(_ sender: Any) {
        if category != "Fungizid" {
            category = "Fungizid"
            fungicideButton.backgroundColor = UIColor.gray
            herbicideButton.backgroundColor = UIColor.white
            insecticideButton.backgroundColor = UIColor.white
        }
    }
    
    /// Ändert die Pflanzenschutzmittel-Kategorie zu "Herbizid" und hebt den entsprechenden Button hervor.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func pressHerbicide(_ sender: Any) {
        if category != "Herbizid" {
            category = "Herbizid"
            fungicideButton.backgroundColor = UIColor.white
            herbicideButton.backgroundColor = UIColor.gray
            insecticideButton.backgroundColor = UIColor.white
        }
    }
    
    /// Ändert die Pflanzenschutzmittel-Kategorie zu "Insektizid/Akarizid" und hebt den entsprechenden Button hervor.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func pressInsecticide(_ sender: Any) {
        if category != "Insektizid/Akarizid" {
            category = "Insektizid/Akarizid"
            fungicideButton.backgroundColor = UIColor.white
            herbicideButton.backgroundColor = UIColor.white
            insecticideButton.backgroundColor = UIColor.gray
        }
    }
    
    /// Löscht den angezeigten Eintrag aus der Datenbank.
    func deleteEntry() {
        let db = RealmHelper()
        if let entry = entry {
            db.deletePflanzenschutz(entry: entry)
            performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        } else {
            _ = UIAlertController(title: "Eintrag löschen", message: "Löschen fehlgeschlagen", preferredStyle: .alert)
            
        }
        
    }
    
    /// Bereitet die Weiterleitung des Nutzers zur Übersicht über die gespeicherten Arbeitsvorgänge oder Aufwände vor.
    ///
    /// - Parameters:
    ///   - segue: Der Segue, der zur Übersicht der Einträge weiterleitet.
    ///   - sender: Der gedrückte button.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = captureType
        }
    }
    
    /// Gibt die Anzahl der zu wählenden Elemente der PcikerView zurück.
    ///
    /// - Parameter pickerView: Die betreffende PickerView
    /// - Returns: Die Anzahl der zu wählenden Elemente der PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// Gibt die Anzahl der Elemente der PickerView zurück, aus denen ausgewählt werden kann.
    ///
    /// - Parameters:
    ///   - pickerView: Die betreffende PickerView
    ///   - component: Anzahl der Elemente, die gleichzeitig gewählt werden können
    /// - Returns: Anzahl der Elemente, aus denen gewählt werden kann
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return areas.count
    }
    
    /// Gibt die Bezeichnungen der Einträge der PickerView zurück.
    ///
    /// - Parameters:
    ///   - pickerView: Die betreffende PickerView
    ///   - row: Die Zeile des Eintrags der PickerView
    ///   - component: Das Element der PickerView
    /// - Returns: Die Bezeichnung des Eintrags der Zeile
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return areas[row]
    }
    
    /// Lädt die Felder aus der Datenbank.
    private func loadAreasFromRealm(){
        var entryList = [Entry]()
        let db = RealmHelper()
        entryList = db.loadObjects(type: "Area")
        
        
        entryList.forEach { (entry) in
            areas.append(entry.areaName!)
        }
        areaPicker.reloadAllComponents()
    }
    
    
    
}
