//
//  RealmHelper.swift
//  WeinbergApp
//
//  Created by ema on 03.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    func addGeneral(captureType: String, benutzer: String, feld: String, arbeitszeit: Double, datum: Date ) {
        let realm = try! Realm()
        
        let newEntry = GeneralEntry()
        newEntry.captureType = captureType
        newEntry.Benutzer = benutzer
        newEntry.Feld = feld
        newEntry.Arbeitszeit = arbeitszeit
        newEntry.Datum = datum
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func loadObjects (type: String) -> [Entry] {
        let realm = try! Realm()
        
        let objects = realm.objects(GeneralEntry.self).filter("captureType = ", type)
        
        var entries: [Entry] = []
        
        for i in 0..<objects.count {
            let entry = Entry(user: objects[i].Benutzer, date: objects[i].Datum, field: objects[i].Feld, hours: objects[i].Arbeitszeit, captureType: objects[i].captureType)
            entries.append(entry)
        }
        return entries
    }
}

class GeneralEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit: Double = 0.0
    @objc dynamic var Datum = Date()
}
