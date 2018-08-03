//
//  AddEntryViewController.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 18.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class AddEntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    var entry: Entry?
    var captureType: String?
    var areas = [String]()
    @IBOutlet weak var headCaptureLabel: UILabel!
    @IBOutlet weak var traubenleseDurchfuehrungView: UIStackView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var areaPicker: UIPickerView!
    @IBOutlet weak var benutzerText: UITextField!
    @IBOutlet weak var arbeitszeitText: UITextField!
    @IBOutlet weak var durchfuehrungText: UITextField!
    
    /// Zeigt den zuvor gewählten Eintrag an oder legt einen neuen Eintrag an.
    override func viewDidLoad() {
        super.viewDidLoad()
        headCaptureLabel.text = captureType
        loadAreasFromRealm()
        self.areaPicker.delegate = self
        self.areaPicker.dataSource = self
        
        if let entry = entry {
            captureType = entry.getCaptureType()
            headCaptureLabel.text =  entry.getCaptureType()
            
    
            benutzerText.text = entry.getUser()
            arbeitszeitText.text = String(entry.getHours())
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: entry.getDate()){
                datePicker.date = date
            }
            if (entry.getField().characters.count > 0){
                areaPicker.selectRow(areas.index(of: entry.getField())!, inComponent: 0, animated: true)
                
            }
        }
        
        if checkTraubenlese() {
            durchfuehrungText.text = entry?.durchfuehrung
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
        
        if captureType == "Traubenlese"{
            if durchfuehrungText.text != nil && benutzerText.text != nil && arbeitszeitText.text != nil && arbeitszeitText.text != nil{
                db.addTraubenlese(captureType: captureType!, benutzer: benutzerText.text!, feld: areas[areaPicker.selectedRow(inComponent: 0)], arbeitszeit: arbeitszeitText.text!, datum: date, durchfuehrung: durchfuehrungText.text!)
            }
        } else {
            if captureType != nil && benutzerText.text != nil && arbeitszeitText != nil && arbeitszeitText.text != nil && areas.count > 0{
                db.addGeneral(captureType: captureType!, benutzer: benutzerText.text!, feld: areas[areaPicker.selectedRow(inComponent: 0)], arbeitszeit: arbeitszeitText.text!, datum: date)
            }
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
    @IBAction func PressDeleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Eintrag löschen", message: "Möchten Sie diesen Eintrag wirklich löschen?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { (nil) in
            self.deleteEntry()
        }))
        alert.addAction(UIAlertAction(title: "Nein", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /// Löscht den angezeigten Eintrag aus der Datenbank.
    func deleteEntry() {
        let db = RealmHelper()
        if let entry = entry {
            if captureType == "Traubenlese" {
                db.deleteTraubenlese(entry: entry)
            } else {
            db.deleteGeneral(entry: entry)
            }
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
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = captureType
        }
    }
    
    /// Prüft, ob es sich um einen Eintrag des Arbeitsvorgangs "Traubenlese" handelt.
    ///
    /// - Returns: true, falls "Traubenlese"; false, sonst
    func checkTraubenlese()  -> Bool{
        if captureType == "Traubenlese" {
            traubenleseDurchfuehrungView.isHidden = false
            return true;
        } else {
            return false;
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
