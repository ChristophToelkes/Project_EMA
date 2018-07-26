//
//  AddElectricalEquipment.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 25.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class AddElectricalEquipmentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var optionPicker: UIPickerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jearTestField: UITextField!
    @IBOutlet weak var kwhLabel: UILabel!
    @IBOutlet weak var kwhTestField: UITextField!
    @IBOutlet weak var consumerTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeTestField: UITextField!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var powerTestField: UITextField!
    private var inputKWH = true
    public var entry: Entry?
    public var captureType: String?
    private let options = ["Abfüllung",
                           "Filtration",
                           "Kühlung",
                           "Lagerung",
                           "Maischebehandlung",
                           "Mostvorklärung",
                           "Traubenverarbeitung",
                           "Sonstiges"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = captureType
        optionPicker.delegate = self
        optionPicker.dataSource = self
        
        if let entry = entry {
            captureType = entry.getCaptureType()
            titleLabel.text =  entry.getCaptureType()
            jearTestField.text = entry.getJahr()
            kwhTestField.text = entry.getkwh()
            powerTestField.text = entry.getLeistung()
            timeTestField.text = entry.getLaufzeit()
            optionPicker.selectRow(options.index(of: entry.getAspekt())!, inComponent: 0, animated: true)
        
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    @IBAction func changeInputType(_ sender: UISegmentedControl) {
        if(self.inputKWH){
            kwhLabel.isEnabled = false
            kwhTestField.isEnabled = false
            powerLabel.isEnabled = true
            powerTestField.isEnabled = true
            timeLabel.isEnabled = true
            timeTestField.isEnabled = true
            inputKWH = false
        } else {
            kwhLabel.isEnabled = true
            kwhTestField.isEnabled = true
            powerLabel.isEnabled = false
            powerTestField.isEnabled = false
            timeLabel.isEnabled = false
            timeTestField.isEnabled = false
            inputKWH = true
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let db = RealmHelper()
   
        if(inputKWH){
            db.addEnergy(jahr: jearTestField.text!, Verbraucher: consumerTextField.text!, aspekt: options[optionPicker.selectedRow(inComponent: 0)], captureType: captureType!, kwh: kwhTestField.text!, leistung: "", laufzeit: "")
        } else {
            db.addEnergy(jahr: jearTestField.text!, Verbraucher: consumerTextField.text!, aspekt: options[optionPicker.selectedRow(inComponent: 0)], captureType: captureType!, kwh: "", leistung: powerTestField.text!, laufzeit: timeTestField.text!)
        }
     
   
    }
    
    @IBAction func deleteEntryBtn(_ sender: Any) {
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
           
            db.deleteEnergy(entry: entry)
            
            
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

    
}
