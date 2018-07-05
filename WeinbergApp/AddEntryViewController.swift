//
//  AddEntryViewController.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 18.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class AddEntryViewController: UIViewController {
    
    var entry: Entry?
    var captureType: String?
    @IBOutlet weak var headCaptureLabel: UILabel!
    @IBOutlet weak var traubenleseDurchfuehrungView: UIStackView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var feldText: UITextField!
    @IBOutlet weak var benutzerText: UITextField!
    @IBOutlet weak var arbeitszeitText: UITextField!
    @IBOutlet weak var durchfuehrungText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headCaptureLabel.text = captureType
        
        if let entry = entry {
            captureType = entry.getCaptureType()
            headCaptureLabel.text =  entry.getCaptureType()
            
            feldText.text = entry.getField()
            benutzerText.text = entry.getUser()
            arbeitszeitText.text = String(entry.getHours())
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: entry.getDate()){
                datePicker.date = date
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
                db.addTraubenlese(captureType: captureType!, benutzer: benutzerText.text!, feld: feldText.text!, arbeitszeit: arbeitszeitText.text!, datum: date, durchfuehrung: durchfuehrungText.text!)
            }
        } else {
            if captureType != nil && benutzerText.text != nil && arbeitszeitText != nil && arbeitszeitText.text != nil{
                db.addGeneral(captureType: captureType!, benutzer: benutzerText.text!, feld: feldText.text!, arbeitszeit: arbeitszeitText.text!, datum: date)
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
    
}
