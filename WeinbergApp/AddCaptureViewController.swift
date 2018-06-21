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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = entryList[indexPath.row].getCaptureType()
        cell?.detailTextLabel?.text = entryList[indexPath.row].getDate()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "segueToAddEntryView", sender: self)
        changeEntry = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddEntryViewController{
            if changeEntry {
                destination.entry = entryList[(tableView.indexPathForSelectedRow?.row)!]
                changeEntry = false
            } else {
                destination.captureType = element
            }
        }
    }
    
    @IBAction func addEntryBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddEntryView", sender: self)
    }
    
}
