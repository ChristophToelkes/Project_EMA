//
//  CaptureViewController.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 17.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class CaptureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private let listElements = [String](arrayLiteral: "Entlaubel",
                                                        "Düngung",
                                                        "Grubbern",
                                                        "Rebholz hächseln",
                                                        "Rebschnitt",
                                                        "Mulchen",
                                                        "Pflanzenschutz",
                                                        "Traubenlese",
                                                        "Tresterausbringung",
                                                        "Sonstiges")
    private var listIcons = [UIImage](arrayLiteral: #imageLiteral(resourceName: "laub Kopie"), #imageLiteral(resourceName: "duengen Kopie"), #imageLiteral(resourceName: "feld Kopie"), #imageLiteral(resourceName: "holz Kopie"), #imageLiteral(resourceName: "pflanze2 Kopie"), #imageLiteral(resourceName: "feld Kopie"), #imageLiteral(resourceName: "pflanzenschutz Kopie"), #imageLiteral(resourceName: "trauben Kopie"), #imageLiteral(resourceName: "pflanze Kopie"), #imageLiteral(resourceName: "fass Kopie"))
    
  
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
   
        
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = listElements[indexPath.row]
        cell?.imageView?.image = listIcons[indexPath.row]
        cell?.contentView.sizeToFit()
      
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = listElements[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}
