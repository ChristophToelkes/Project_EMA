//
//  AddCaptureViewController.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 17.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class AddCaptureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var element: String?
    var entryList =  [Entry]()
    var entryListFilter =  [Entry]()
    private var changeEntry = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UISearchBar!
    
    
    /// Lädt die View und deren Einträge.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBarView.delegate = self
        loadEntries()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        entryListFilter = []
        
        entryList.forEach { (e) in
            e.getAll().forEach({ (arg) in
                if(arg.contains(searchText)){
                    entryListFilter.append(e)
                }
            })
        }
        tableView.reloadData()
    }

   

    /// Gibt die Anzahl der Einträge zurück.
    ///
    /// - Parameters:
    ///   - tableView: Die aufrufende TableView
    ///   - section: Der aufgerufene Abschnitt
    /// - Returns: Die Anzahl der Einträge der TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryListFilter.count
    }
    
    /// Erstellt die Zellen der TableView und gibt sie zurück.
    ///
    /// - Parameters:
    ///   - tableView: Die aufrufende TableView
    ///   - indexPath: Die Zeile der Zelle
    /// - Returns: Die angeforderte Zelle
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = entryListFilter[indexPath.row].getCaptureType()
        cell?.detailTextLabel?.text = entryListFilter[indexPath.row].getDate()
        
        return cell!
    }
    
    /// Leitet den Nutzer, in Abhängigkeit des gewählten Arbeitsgangs oder Aufwandes, zur entsprechenden
    /// Eintragungsoberfläche weiter.
    ///
    /// - Parameters:
    ///   - tableView: Die aufrufende TableView
    ///   - indexPath: Die Zeile der gewählten Zelle
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(element == "Düngung"){
            changeEntry = true
            performSegue(withIdentifier: "segueToDuengungAddEntryView", sender: self)
        } else if(element == "Pflanzenschutz") {
            changeEntry = true
            performSegue(withIdentifier: "segueToPflanzenschutzAddEntryView", sender: self)
            
        } else if(element == "Thermischer Aufwand" || element == "Stoffströme") {
            changeEntry = true
            performSegue(withIdentifier: "segueToMaterialFlowViewController", sender: self)
            
        } else if(element == "Elektrischer Aufwand") {
            changeEntry = true
            performSegue(withIdentifier: "segueToAddElectricalEquipmentViewController", sender: self)
            
        } else {
            changeEntry = true
            performSegue(withIdentifier: "segueToAddEntryView", sender: self)
        }
        
    }
    
    /// Ruft die, je nach Arbeitsgang oder Aufwand, entsprechende Vorbereitungsroutine auf.
    ///
    /// - Parameters:
    ///   - segue: Der entsprechende Segue der folgenden Oberfläche
    ///   - sender: Die aufrufende Zelle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if(element == "Düngung") {
            prepareDuengung(for: segue, sender: sender)
        } else if(element == "Pflanzenschutz") {
            preparePflanzenschutz(for: segue, sender: sender)
        } else if(element == "Thermischer Aufwand" || element == "Stoffströme") {
           prepareMaterialFlows(for: segue, sender: sender)
        } else if(element == "Elektrischer Aufwand") {
            prepareElectricalEquipment(for: segue, sender: sender)
        } else {
            prepareGeneral(for: segue, sender: sender)
        }
    }
    
    /// Bereitet die Oberfläche für generelle Eintragungen vor.
    ///
    /// - Parameters:
    ///   - segue: Der Segue zur generellen Oberfläche
    ///   - sender: Die aufrufende Zelle
    func prepareGeneral(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddEntryViewController{
            if changeEntry {
                destination.entry = entryListFilter[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    /// Bereitet die Oberfläche für Eintragungen für elektrischen Aufwand vor.
    ///
    /// - Parameters:
    ///   - segue: Der Segue zur Oberfläche für elektrischen Aufwand
    ///   - sender: Die aufrufende Zelle
    func prepareElectricalEquipment(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddElectricalEquipmentViewController{
            if changeEntry {
                destination.entry = entryListFilter[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    /// Bereitet die Oberfläche für Eintragungen für Stoffströme und Thermische Aufwände vor.
    ///
    /// - Parameters:
    ///   - segue: Der Segue zur Oberfläche für Stoffströme und Thermische Aufwände
    ///   - sender: Die aufrufende Zelle
    func prepareMaterialFlows(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddMaterialFlowsORThermalViewController{
            if changeEntry {
                destination.entry = entryListFilter[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    /// Bereitet die Oberfläche für Eintragungen für Düngung vor.
    ///
    /// - Parameters:
    ///   - segue: Der Segue zur Oberfläche für Düngung
    ///   - sender: Die aufrufende Zelle
    func prepareDuengung(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DuengungAddEntryViewController{
            if changeEntry {
                destination.entry = entryListFilter[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    /// Bereitet die Oberfläche für Eintragungen für Pflanzenschutz vor.
    ///
    /// - Parameters:
    ///   - segue: Der Segue zur Oberfläche für Pflanzenschutz
    ///   - sender: Die aufrufende Zelle
    func preparePflanzenschutz(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PflanzenschutzAddEntryViewController{
            if changeEntry {
                destination.entry = entryListFilter[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    
    

    /// Leitet den Nutzer zur Oberfläche für eine neue Eintragung des entsprechenden Arbeitsgangs oder Aufwands weiter.
    ///
    /// - Parameter sender: Der gedrückte Button
    @IBAction func addEntryBtn(_ sender: Any) {
        if(element == "Düngung"){
            performSegue(withIdentifier: "segueToDuengungAddEntryView", sender: self)
        } else if (element == "Pflanzenschutz"){
            performSegue(withIdentifier: "segueToPflanzenschutzAddEntryView", sender: self)
        } else if(element == "Thermischer Aufwand" || element == "Stoffströme") {
            performSegue(withIdentifier: "segueToMaterialFlowViewController", sender: self)
        } else if(element == "Elektrischer Aufwand") {
            performSegue(withIdentifier: "segueToAddElectricalEquipmentViewController", sender: self)
        } else {
            performSegue(withIdentifier: "segueToAddEntryView", sender: self)
        }
    }
    
    /// Lädt bereits bestehende Eintragungen aus der Datenbank.
    func loadEntries(){
        let db = RealmHelper()
        if let captureType = element {
            entryList = db.loadObjects(type: captureType)
            entryListFilter = entryList
        }
    }
}
