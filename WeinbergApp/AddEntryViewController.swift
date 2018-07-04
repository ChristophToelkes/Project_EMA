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
            datePicker.date = entry.getDate()
            feldText.text = entry.getField()
            benutzerText.text = entry.getUser()
            arbeitszeitText.text = String(entry.getHours())
        }
        
        if checkTraubenlese() {
            durchfuehrungText.text = entry?.durchfuehrung
        }
    }
    //Es gibt bisher keine Fehlermeldung bei unvollständigem Ausfüllen
    @IBAction func safeEntryBtn(_ sender: Any) {
        let db = RealmHelper()
        
        if captureType == "Traubenlese"{
            if durchfuehrungText.text != nil && benutzerText.text != nil && arbeitszeitText.text != nil {
                if let zeit = Double(arbeitszeitText.text!) {
                    db.addTraubenlese(captureType: captureType!, benutzer: benutzerText.text!, feld: feldText.text!, arbeitszeit: zeit, datum: datePicker.date, durchfuehrung: durchfuehrungText.text!)
                }
            }
        } else {
            if captureType != nil && benutzerText.text != nil && arbeitszeitText != nil {
                if let zeit = Double(arbeitszeitText.text!) {
                    db.addGeneral(captureType: captureType!, benutzer: benutzerText.text!, feld: feldText.text!, arbeitszeit: zeit, datum: datePicker.date)
                }
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        
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
