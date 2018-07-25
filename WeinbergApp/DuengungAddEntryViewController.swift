//
//  DuengungAddEntryViewController.swift
//  WeinbergApp
//
//  Created by ema on 27.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class DuengungAddEntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var entry: Entry?
    var captureType: String?
    var areas = [String]()
    @IBOutlet weak var headCaptureLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var areaPicker: UIPickerView!
    @IBOutlet weak var benutzerText: UITextField!
    @IBOutlet weak var arbeitszeitText: UITextField!
    @IBOutlet weak var duengemittelText: UITextField!
    @IBOutlet weak var mengeDuengemittelText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headCaptureLabel.text = captureType


        self.areaPicker.delegate = self
        self.areaPicker.dataSource = self
        loadAreasFromRealm()
        
        if let entry = entry {
            captureType = entry.getCaptureType()
            headCaptureLabel.text =  entry.getCaptureType()
            benutzerText.text = entry.getUser()
            arbeitszeitText.text = String(entry.getHours())
            duengemittelText.text = entry.getDuengemittel()
            mengeDuengemittelText.text = String(entry.getMengeDuengemittel())
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: entry.getDate()){
                datePicker.date = date
            }
            if (entry.getField().characters.count > 0){
                areaPicker.selectRow(areas.index(of: entry.getField())!, inComponent: 0, animated: false)
                
            }
        }
    }
    
    @IBAction func safeEntryBtn(_ sender: Any) {
        let db = RealmHelper()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: datePicker.date)
        
        if captureType != nil && benutzerText.text != nil && arbeitszeitText.text != nil && duengemittelText.text != nil && mengeDuengemittelText.text != nil && arbeitszeitText.text != nil && mengeDuengemittelText.text != nil && areas[areaPicker.selectedRow(inComponent: 0)].characters.count > 0{
            db.addDuengung(captureType: captureType!, benutzer: benutzerText.text!, feld: areas[areaPicker.selectedRow(inComponent: 0)], arbeitszeit: arbeitszeitText.text!, datum: date, duengemittel: duengemittelText.text!, mengeDuengemittel: mengeDuengemittelText.text!)

        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        
    }
    
    @IBAction func pressDeleteButton(_ sender: Any) {
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
            db.deleteDuengung(entry: entry)
            performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        } else {
            _ = UIAlertController(title: "Eintrag löschen", message: "Löschen fehlgeschlagen", preferredStyle: .alert)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = captureType
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
