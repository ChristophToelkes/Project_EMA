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
    @IBOutlet weak var yearTestField: UITextField!
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
    
    
    /// Zeigt den zuvor gewählten Eintrag an oder legt einen neuen Eintrag an.
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = captureType
        optionPicker.delegate = self
        optionPicker.dataSource = self
        
        if let entry = entry {
            captureType = entry.getCaptureType()
            titleLabel.text =  entry.getCaptureType()
            yearTestField.text = entry.getYear()
            kwhTestField.text = entry.getkwh()
            powerTestField.text = entry.getLeistung()
            timeTestField.text = entry.getLaufzeit()
            optionPicker.selectRow(options.index(of: entry.getAspekt())!, inComponent: 0, animated: true)
        
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
        return options.count
    }
    
    /// Gibt die Bezeichnungen der Einträge der PickerView zurück.
    ///
    /// - Parameters:
    ///   - pickerView: Die betreffende PickerView
    ///   - row: Die Zeile des Eintrags der PickerView
    ///   - component: Das Element der PickerView
    /// - Returns: Die Bezeichnung des Eintrags der Zeile
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    /// Wechselt zwischen der Eingabemöglichkeit von kwh oder PS und h
    ///
    /// - Parameter sender: Der gedrückte Button
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
    
    /// Speichert den Eintrag in der Datenbank.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func addBtn(_ sender: Any) {
        let db = RealmHelper()
   
        if(inputKWH){
            db.addEnergy(year: yearTestField.text!, Consumptioner: consumerTextField.text!, aspekt: options[optionPicker.selectedRow(inComponent: 0)], captureType: captureType!, kwh: kwhTestField.text!, power: "", runtime: "")
        } else {
            db.addEnergy(year: yearTestField.text!, Consumptioner: consumerTextField.text!, aspekt: options[optionPicker.selectedRow(inComponent: 0)], captureType: captureType!, kwh: "", power: powerTestField.text!, runtime: timeTestField.text!)
        }
     
   
    }
    
    /// Fragt den Nutzer, ob der angezeigt Eintrag gelöscht werden soll.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func deleteEntryBtn(_ sender: Any) {
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
           
            db.deleteEnergy(entry: entry)
            
            
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

    
}
