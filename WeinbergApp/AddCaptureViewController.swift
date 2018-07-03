//
//  AddCaptureViewController.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 17.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import UIKit

class AddCaptureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var element: String?
    var entryList =  [Entry]()
    private var changeEntry = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadEntries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = entryList[indexPath.row].getCaptureType()
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: entryList[indexPath.row].getDate())
        cell?.detailTextLabel?.text = dateString
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(element == "Düngung"){
            performSegue(withIdentifier: "segueToDuengungAddEntryView", sender: self)
            changeEntry = true
        } else {
            performSegue(withIdentifier: "segueToAddEntryView", sender: self)
            changeEntry = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(element == "Düngung") {
            prepareDuengung(for: segue, sender: sender)
        } else if(element == "Pflanzenschutz") {
            preparePflanzenschutz(for: segue, sender: sender)
        } else {
            prepareGeneral(for: segue, sender: sender)
        }
    }
    
    func prepareGeneral(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddEntryViewController{
            if changeEntry {
                destination.entry = entryList[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    func prepareDuengung(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DuengungAddEntryViewController{
            if changeEntry {
                destination.entry = entryList[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    func preparePflanzenschutz(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PflanzenschutzAddEntryViewController{
            if changeEntry {
                destination.entry = entryList[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    @IBAction func addEntryBtn(_ sender: Any) {
        if(element == "Düngung"){
            performSegue(withIdentifier: "segueToDuengungAddEntryView", sender: self)
        } else if (element == "Pflanzenschutz"){
            performSegue(withIdentifier: "segueToPflanzenschutzAddEntryView", sender: self)
        } else {
            performSegue(withIdentifier: "segueToAddEntryView", sender: self)
        }
    }
    
    func loadEntries(){
        let db = RealmHelper()
        if let captureType = element {
            entryList = db.loadObjects(type: captureType)
        }
    }
}
