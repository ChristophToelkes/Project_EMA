//
//  PflanzenschutzAddEntryViewController.swift
//  WeinbergApp
//
//  Created by ema on 27.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class PflanzenschutzAddEntryViewController: UIViewController {
    
    var entry: Entry?
    var captureType: String?
    @IBOutlet weak var headCaptureLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var feldText: UITextField!
    @IBOutlet weak var benutzerText: UITextField!
    @IBOutlet weak var arbeitszeitText: UITextField!
    @IBOutlet weak var gegenText: UITextField!
    @IBOutlet weak var mittelText: UITextField!
    @IBOutlet weak var terminText: UITextField!
    @IBOutlet weak var infoText: UITextField!
    @IBOutlet weak var mengePflanzenschutzmittelText: UITextField!
    
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
            gegenText.text = entry.getGegen()
            mittelText.text = entry.getMittel()
            terminText.text = entry.getTermin()
            infoText.text = entry.getInfo()
            mengePflanzenschutzmittelText.text = String(entry.getMengePflanzenschutzmittel())
        }
    }
    
    @IBAction func safeEntryBtn(_ sender: Any) {
        let db = RealmHelper()
        
        if captureType != nil && benutzerText.text != nil && arbeitszeitText.text != nil && gegenText.text != nil && mittelText.text != nil && terminText.text != nil && infoText.text != nil && mengePflanzenschutzmittelText.text != nil{
            if let zeit = Double(arbeitszeitText.text!), let mengePflanzenschutzmittel = Double(mengePflanzenschutzmittelText.text!) {
                db.addPflanzenschutz(captureType: captureType!, benutzer: benutzerText.text!, feld: feldText.text!, arbeitszeit: zeit, datum: datePicker.date, gegen: gegenText.text!, mittel: mittelText.text!, termin: terminText.text!, info: infoText.text!, mengePflanzenschutzmittel: mengePflanzenschutzmittel)
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = captureType
        }
    }
    
}
