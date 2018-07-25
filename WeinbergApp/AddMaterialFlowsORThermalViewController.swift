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
   
    
    @IBOutlet weak var optionPicker: UIPickerView!
    
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
