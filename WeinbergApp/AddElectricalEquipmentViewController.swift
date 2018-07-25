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
    
   
}
