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
    private let listElements = [[String]](arrayLiteral: ["Entlauben",
                                                        "Düngung",
                                                        "Grubbern",
                                                        "Rebholz hächseln",
                                                        "Rebschnitt",
                                                        "Mulchen",
                                                        "Pflanzenschutz",
                                                        "Traubenlese",
                                                        "Tresterausbringung",
                                                        "Sonstiges"],["Thermischer Aufwand", "Elektrischer Aufwand", "Stoffströme"])
    private let listIcons = [[UIImage]](arrayLiteral: [#imageLiteral(resourceName: "laub Kopie"), #imageLiteral(resourceName: "duengen Kopie"), #imageLiteral(resourceName: "feld Kopie"), #imageLiteral(resourceName: "holz Kopie"), #imageLiteral(resourceName: "pflanze2 Kopie"), #imageLiteral(resourceName: "feld Kopie"), #imageLiteral(resourceName: "pflanzenschutz Kopie"), #imageLiteral(resourceName: "trauben Kopie"), #imageLiteral(resourceName: "pflanze Kopie"), #imageLiteral(resourceName: "fass Kopie")], [#imageLiteral(resourceName: "stone-oven"), #imageLiteral(resourceName: "lightning-electric-energy"), #imageLiteral(resourceName: "oil")])
    private let sectionTitle = ["Arbeitsgänge", "Aufwände"]
    
  
    
    @IBAction func logoutBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueLogout2", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listElements[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = listElements[indexPath.section][indexPath.row]
        cell?.imageView?.image = listIcons[indexPath.section][indexPath.row]
        cell?.contentView.sizeToFit()
      
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = listElements[(tableView.indexPathForSelectedRow?.section)!][(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
 
    
}
