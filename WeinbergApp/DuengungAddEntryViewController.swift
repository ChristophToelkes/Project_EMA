//
//  DuengungAddEntryViewController.swift
//  WeinbergApp
//
//  Created by ema on 27.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class DuengungAddEntryViewController: UIViewController {
    
    var entry: Entry?
    var captureType: String?
    @IBOutlet weak var headCaptureLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var feldText: UITextField!
    @IBOutlet weak var benutzerText: UITextField!
    @IBOutlet weak var arbeitszeitText: UITextField!
    @IBOutlet weak var duengemittelText: UITextField!
    @IBOutlet weak var mengeDuengemittelText: UITextField!
    
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
            duengemittelText.text = entry.getDuengemittel()
            mengeDuengemittelText.text = String(entry.getMengeDuengemittel())
        }
    }
    
    @IBAction func safeEntryBtn(_ sender: Any) {
        let db = RealmHelper()
        
        if captureType != nil && benutzerText.text != nil && arbeitszeitText.text != nil && duengemittelText.text != nil && mengeDuengemittelText.text != nil{
            if let zeit = Double(arbeitszeitText.text!), let mengeDuengemittel = Double(mengeDuengemittelText.text!) {
                db.addDuengung(captureType: captureType!, benutzer: benutzerText.text!, feld: feldText.text!, arbeitszeit: zeit, datum: datePicker.date, duengemittel: duengemittelText.text!, mengeDuengemittel: mengeDuengemittel)
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
