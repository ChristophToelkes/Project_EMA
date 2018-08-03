//
//  AddMaterialFlowsORThermal .swift
//  WeinbergApp
//
//  Created by Elena Görgen on 25.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class AddMaterialFlowsORThermalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var optionPicker: UIPickerView!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    private var option = 0
    var entry: Entry?
    var captureType: String?
    private let optionsMaterial = [[String]](arrayLiteral: ["Heizöl",
                                  "Holz",
                                  "Fernwärme",
                                  "Erdwärme",
                                  "Elektrischer Strom",
                                  "Hackschnitzel",
                                  "Flüssiggas"],
                                   ["Frischwasser",
                                    "Abwasser",
                                    "Glas",
                                    "Weissblech",
                                    "Aluminium",
                                    "Papier",
                                    "Kunststoff"])
    
   /// Zeigt den zuvor gewählten Eintrag an oder legt einen neuen Eintrag an.
    override func viewDidLoad() {
        super.viewDidLoad()
        optionPicker.delegate = self
        optionPicker.dataSource = self
        titleLabel.text = captureType
        if (captureType == "Stoffströme"){
            option = 1
        } else {
            option = 0
        }
    }
    
    
    
    /// Fragt den Nutzer, ob der angezeigt Eintrag gelöscht werden soll.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func deleteBtn(_ sender: Any) {
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
            if(option == 1){
                 db.deleteThermal(entry: entry)
            } else {
                 db.deleteMaterial(entry: entry)
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
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = captureType
        }
    }
    
    /// Speichert den Eintrag in der Datenbank.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func addBtn(_ sender: Any) {
        let db = RealmHelper()
       
   
        if (captureType == "Thermischer Aufwand") {
            db.addThermal(year: dateTextField.text!, description: optionsMaterial[option][optionPicker.selectedRow(inComponent: 0)], Consumption: amountTextField.text!, captureType: captureType!)
     
            
        } else if (captureType == "Stoffströme"){
            db.addMaterial(year: dateTextField.text!, description: optionsMaterial[option][optionPicker.selectedRow(inComponent: 0)], Consumption: amountTextField.text!, captureType: captureType!)
        
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
         return optionsMaterial[option].count
    }
    
    /// Gibt die Bezeichnungen der Einträge der PickerView zurück.
    ///
    /// - Parameters:
    ///   - pickerView: Die betreffende PickerView
    ///   - row: Die Zeile des Eintrags der PickerView
    ///   - component: Das Element der PickerView
    /// - Returns: Die Bezeichnung des Eintrags der Zeile
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return optionsMaterial[option][row]
    }
    
    

}
