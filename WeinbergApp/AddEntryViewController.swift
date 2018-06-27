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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headCaptureLabel.text = captureType
        
        
        
    }
    
    @IBAction func safeEntryBtn(_ sender: Any) {
    }
    
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        
    }
    
    
}
