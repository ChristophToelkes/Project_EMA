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
            if captureType != nil && benutzerText.text != nil && arbeitszeitText != nil && arbeitszeitText.text != nil{
                db.addGeneral(captureType: captureType!, benutzer: benutzerText.text!, feld: areas[areaPicker.selectedRow(inComponent: 0)], arbeitszeit: arbeitszeitText.text!, datum: date)
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        
    }
    
    @IBAction func PressDeleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Eintrag löschen", message: "Möchten Sie diesen Eintrag wirklich löschen?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { (nil) in
            self.deleteEntry()
        }))
        alert.addAction(UIAlertAction(title: "Nein", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = captureType
        }
    }
    
    func checkTraubenlese()  -> Bool{
        if captureType == "Traubenlese" {
            traubenleseDurchfuehrungView.isHidden = false
            return true;
        } else {
            return false;
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return areas.count
    }
  
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return areas[row]
    }
    
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
