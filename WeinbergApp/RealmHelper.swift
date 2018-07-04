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
    
    func addTraubenlese(captureType: String, benutzer: String, feld: String, arbeitszeit: Double, datum: Date, durchfuehrung: String) {
        let realm = try! Realm()
        
        let newEntry = TraubenleseEntry()
        newEntry.captureType = captureType
        newEntry.Benutzer = benutzer
        newEntry.Feld = feld
        newEntry.Arbeitszeit = arbeitszeit
        newEntry.Datum = datum
        newEntry.durchfuerung = durchfuehrung
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func addDuengung(captureType: String, benutzer: String, feld: String, arbeitszeit: Double, datum: Date, duengemittel: String, mengeDuengemittel: Double) {
        let realm = try! Realm()
        
        let newEntry = DuengungEntry()
        newEntry.captureType = captureType
        newEntry.Benutzer = benutzer
        newEntry.Feld = feld
        newEntry.Arbeitszeit = arbeitszeit
        newEntry.Datum = datum
        newEntry.duengemittel = duengemittel
        newEntry.mengeDuengemittel = mengeDuengemittel
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func addPflanzenschutz(captureType: String, benutzer: String, feld: String, arbeitszeit: Double, datum: Date, gegen: String, mittel: String, termin: String, info: String, mengePflanzenschutzmittel: Double) {
        let realm = try! Realm()
        
        let newEntry = PflanzenschutzEntry()
        newEntry.captureType = captureType
        newEntry.Benutzer = benutzer
        newEntry.Feld = feld
        newEntry.Arbeitszeit = arbeitszeit
        newEntry.Datum = datum
        newEntry.gegen = gegen
        newEntry.mittel = mittel
        newEntry.termin = termin
        newEntry.info = info
        newEntry.mengePflanzenschutzmittel = mengePflanzenschutzmittel
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func loadObjects (type: String) -> [Entry] {
        var entries: [Entry] = []
        switch type {
        case "Traubenlese":
               entries = getTraubenleseEntries(results: getTraubenleseObjects(type: type))
        case "Düngung":
                entries = getDuengungEntries(results: getDuengungObjects(type: type))
        case "Pflanzenschutz":
                entries = getPflanzenschutzEntries(results: getPflanzenschutzObjects(type: type))
        default:
            entries = getGeneralEntries(results: getGeneralObjects(type: type))
        }
        return entries
    }
    
    func getTraubenleseObjects(type: String) -> Results<TraubenleseEntry> {
        let realm = try! Realm()
        
        return realm.objects(TraubenleseEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getTraubenleseEntries(results: Results<TraubenleseEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(user: results[i].Benutzer, date: results[i].Datum, field: results[i].Feld, hours: results[i].Arbeitszeit, captureType: results[i].captureType, durchfuehrung: results[i].durchfuerung, duengemittel: nil, mengeDuengemittel: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getDuengungObjects(type: String) -> Results<DuengungEntry> {
        let realm = try! Realm()
        
        return realm.objects(DuengungEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getDuengungEntries(results: Results<DuengungEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(user: results[i].Benutzer, date: results[i].Datum, field: results[i].Feld, hours: results[i].Arbeitszeit, captureType: results[i].captureType, durchfuehrung: nil, duengemittel: results[i].duengemittel, mengeDuengemittel: results[i].mengeDuengemittel, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getPflanzenschutzObjects(type: String) -> Results<PflanzenschutzEntry> {
        let realm = try! Realm()
        
        return realm.objects(PflanzenschutzEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getPflanzenschutzEntries(results: Results<PflanzenschutzEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(user: results[i].Benutzer, date: results[i].Datum, field: results[i].Feld, hours: results[i].Arbeitszeit, captureType: results[i].captureType, durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, gegen: results[i].gegen, mittel: results[i].mittel, termin: results[i].termin, info: results[i].info, mengePflanzenschutzmittel: results[i].mengePflanzenschutzmittel)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getGeneralObjects(type: String) -> Results<GeneralEntry> {
        let realm = try! Realm()
        
        return realm.objects(GeneralEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getGeneralEntries(results: Results<GeneralEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(user: results[i].Benutzer, date: results[i].Datum, field: results[i].Feld, hours: results[i].Arbeitszeit, captureType: results[i].captureType, durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
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

class TraubenleseEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit: Double = 0.0
    @objc dynamic var Datum = Date()
    @objc dynamic var durchfuerung = ""
}

class DuengungEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit: Double = 0.0
    @objc dynamic var Datum = Date()
    @objc dynamic var duengemittel = ""
    @objc dynamic var mengeDuengemittel: Double = 0.0
}

class PflanzenschutzEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit: Double = 0.0
    @objc dynamic var Datum = Date()
    @objc dynamic var gegen = ""
    @objc dynamic var mittel = ""
    @objc dynamic var termin = ""
    @objc dynamic var info = ""
    @objc dynamic var mengePflanzenschutzmittel: Double = 0.0
}
