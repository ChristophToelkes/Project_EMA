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
        
        checkTraubenlese()
    }
    
    @IBAction func safeEntryBtn(_ sender: Any) {
        let db = RealmHelper()
        if captureType != nil && benutzerText.text != nil && arbeitszeitText != nil {
            if let zeit = Double(arbeitszeitText.text!) {
                db.addGeneral(captureType: captureType!, benutzer: benutzerText.text!, feld: feldText.text!, arbeitszeit: zeit, datum: datePicker.date)
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
    
    func checkTraubenlese() {
        if captureType == "Traubenlese" {
            traubenleseDurchfuehrungView.isHidden = false
        }
    }
    
}
