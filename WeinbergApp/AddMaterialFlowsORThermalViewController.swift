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
    
    
    
    
    @IBAction func deleteBtn(_ sender: Any) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = captureType
        }
    }
    

    @IBAction func addBtn(_ sender: Any) {
        let db = RealmHelper()
       
   
        if (captureType == "Thermischer Aufwand") {
            db.addThermal(jahr: dateTextField.text!, beschreibung: optionsMaterial[option][optionPicker.selectedRow(inComponent: 0)], Verbrauch: amountTextField.text!, captureType: captureType!)
     
            
        } else if (captureType == "Stoffströme"){
            db.addMaterial(jahr: dateTextField.text!, beschreibung: optionsMaterial[option][optionPicker.selectedRow(inComponent: 0)], Verbrauch: amountTextField.text!, captureType: captureType!)
        
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
       
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return optionsMaterial[option].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return optionsMaterial[option][row]
    }
    
    

}
