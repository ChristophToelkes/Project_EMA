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
    
  
    
    /// Leitet den Nutzer zum Login Bildschirm.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func logoutBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueLogout2", sender: self)
    }
    
    
    
    /// Setzt die Delegates der TableView
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    /// Gibt die Anzahl der Einträge der Arbeitsgänge oder Aufwände zurück.
    ///
    /// - Parameters:
    ///   - tableView: Die Aufrufende TableView
    ///   - section: Der Index des aufgerufenen Unterarrays
    /// - Returns: Die Anzahl der Einträge des Unterarrays (Arbeitsgänge oder Aufwände)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listElements[section].count
    }
    
    /// Gibt die Anzahl der Abschnitte der Table View zurück.
    ///
    /// - Parameter tableView: Die aufrufende TableView
    /// - Returns: Anzahl der Abschnitte
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// Gibt die Zellen der TableView mit Beschriftung und Icon zurück.
    ///
    /// - Parameters:
    ///   - tableView: Die aufrufende TableView
    ///   - indexPath: Die Zeile der Zelle
    /// - Returns: Die Zelle der TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = listElements[indexPath.section][indexPath.row]
        cell?.imageView?.image = listIcons[indexPath.section][indexPath.row]
        cell?.contentView.sizeToFit()
      
        return cell!
    }
    
    /// Leitet den Nutzer zur AddCaptureView des entsprechenden Arbeitsgangs oder Aufwands weiter
    ///
    /// - Parameters:
    ///   - tableView: Die aufrufende TableView
    ///   - indexPath: Index der aufgerufenen Zelle
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "segueToAddCaptureView", sender: self)
    }
    
    /// Bereitet die AddCaptureView des ausgewählten Arbeitsgangs oder Aufwands vor.
    ///
    /// - Parameters:
    ///   - segue: Der aufgerufene UIStoryboardSegue
    ///   - sender: Die aufrufende Zelle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddCaptureViewController{
            destination.element = listElements[(tableView.indexPathForSelectedRow?.section)!][(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    

    /// Gibt den Titel des Abschnitts zurück.
    ///
    /// - Parameters:
    ///   - tableView: Die aufrufende TableView
    ///   - section: Der gewünschte Abschnitt
    /// - Returns: Der Titel des Abschnitts
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
 
    
}
