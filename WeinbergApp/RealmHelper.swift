//
//  RealmHelper.swift
//  WeinbergApp
//
//  Created by ema on 03.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class RealmHelper {
    
    let realm = try! Realm()
    
    func addGeneral(captureType: String, benutzer: String, feld: String, arbeitszeit: String, datum: String ) {
        
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
    
    func addArea(areaName: String, points: String, captureType: String) {
        
        let newEntry = AreaEntry()
        newEntry.captureType = captureType
        newEntry.areaName = areaName
        newEntry.points = points
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func addThermal(year: String, description: String, Consumption: String, captureType: String) {
        
        let newEntry = ThermalEntry()
        newEntry.captureType = captureType
        newEntry.Year = year
        newEntry.Description = description
        newEntry.Consumption = Consumption
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func addMaterial(year: String, description: String, Consumption: String, captureType: String) {
        
        let newEntry = MaterialEntry()
        newEntry.captureType = captureType
        newEntry.Year = year
        newEntry.Description = description
        newEntry.Consumption = Consumption
        
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func addEnergy(year: String, Consumptioner: String, aspekt: String, captureType: String, kwh: String, power: String, runtime: String) {
        
        let newEntry = EnergyEntry()
        newEntry.captureType = captureType
        newEntry.Year = year
        newEntry.Aspekt = aspekt
        newEntry.Consumptioner = Consumptioner
        newEntry.kwh = kwh
        newEntry.Leistung = power
        newEntry.Laufzeit = runtime
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func addTraubenlese(captureType: String, benutzer: String, feld: String, arbeitszeit: String, datum: String, durchfuehrung: String) {

        
        let newEntry = TraubenleseEntry()
        newEntry.captureType = captureType
        newEntry.Benutzer = benutzer
        newEntry.Feld = feld
        newEntry.Arbeitszeit = arbeitszeit
        newEntry.Datum = datum
        newEntry.durchfuehrung = durchfuehrung
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    func addDuengung(captureType: String, benutzer: String, feld: String, arbeitszeit: String, datum: String, duengemittel: String, mengeDuengemittel: String) {

        
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
    
    func addPflanzenschutz(captureType: String, benutzer: String, feld: String, arbeitszeit: String, datum: String, gegen: String, mittel: String, termin: String, info: String, mengePflanzenschutzmittel: String) {
        
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
        case "Area":
            entries = getAreaEntries(results: getAreaObjects(type: type))
        case "Stoffströme":
            entries = getMaterialEntries(results: getMaterialObjects(type: type))
        case "Elektrischer Aufwand":
            entries = getEnergyEntries(results: getEnergyObjects(type: type))
        case "Thermischer Aufwand":
            entries = getThermalEntries(results: getThermalObjects(type: type))
        default:
            entries = []
        }
        return entries
    }
    
    func getMaterialObjects(type: String) -> Results<MaterialEntry> {
        
        return realm.objects(MaterialEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getMaterialEntries(results: Results<MaterialEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              consumer: nil,
                              consumption: results[i].Consumption,
                              year: results[i].Year,
                              aspekt: nil,
                              kwh: nil,
                              power: nil,
                              runtime: nil,
                              description: results[i].Description,
                              user: nil,
                              date: nil,
                              field: nil,
                              hours: nil,
                              captureType: results[i].captureType,
                              durchfuehrung: nil,
                              duengemittel: nil,
                              mengeDuengemittel: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getThermalObjects(type: String) -> Results<ThermalEntry> {
        
        return realm.objects(ThermalEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getThermalEntries(results: Results<ThermalEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              consumer: nil,
                              consumption: results[i].Consumption,
                              year: results[i].Year,
                              aspekt: nil,
                              kwh: nil,
                              power: nil,
                              runtime: nil,
                              description: results[i].Description,
                              user: nil,
                              date: nil,
                              field: nil,
                              hours: nil,
                              captureType: results[i].captureType,
                              durchfuehrung: nil,
                              duengemittel: nil,
                              mengeDuengemittel: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getEnergyObjects(type: String) -> Results<EnergyEntry> {
        
        return realm.objects(EnergyEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getEnergyEntries(results: Results<EnergyEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              consumer: results[i].Consumptioner,
                              consumption: nil,
                              year: results[i].Year,
                              aspekt: results[i].Aspekt,
                              kwh: results[i].kwh,
                              power: results[i].Leistung,
                              runtime: results[i].Laufzeit,
                              description: nil,
                              user: nil,
                              date: nil,
                              field: nil,
                              hours: nil,
                              captureType: results[i].captureType,
                              durchfuehrung: nil,
                              duengemittel: nil,
                              mengeDuengemittel: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getTraubenleseObjects(type: String) -> Results<TraubenleseEntry> {
        
        return realm.objects(TraubenleseEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getTraubenleseEntries(results: Results<TraubenleseEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              consumer: nil,
                              consumption: nil,
                              year: nil,
                              aspekt: nil,
                              kwh: nil,
                              power: nil,
                              runtime: nil,
                              description: nil,
                              user: results[i].Benutzer,
                              date: results[i].Datum,
                              field: results[i].Feld,
                              hours: results[i].Arbeitszeit,
                              captureType: results[i].captureType,
                              durchfuehrung: results[i].durchfuehrung,
                              duengemittel: nil,
                              mengeDuengemittel: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getAreaObjects(type: String) -> Results<AreaEntry> {
        
        return realm.objects(AreaEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getAreaEntries(results: Results<AreaEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: results[i].areaName,
                              points: results[i].points,
                              consumer: nil,
                              consumption: nil,
                              year: nil,
                              aspekt: nil,
                              kwh: nil,
                              power: nil,
                              runtime: nil,
                              description: nil,
                              user: nil,
                              date: nil,
                              field: nil,
                              hours: nil,
                              captureType: results[i].captureType,
                              durchfuehrung: nil,
                              duengemittel: nil,
                              mengeDuengemittel: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getDuengungObjects(type: String) -> Results<DuengungEntry> {
        
        return realm.objects(DuengungEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getDuengungEntries(results: Results<DuengungEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points: nil,
                              consumer: nil,
                              consumption: nil,
                              year: nil,
                              aspekt: nil,
                              kwh: nil,
                              power: nil,
                              runtime: nil,
                              description: nil,
                              user: results[i].Benutzer,
                              date: results[i].Datum,
                              field: results[i].Feld,
                              hours: results[i].Arbeitszeit,
                              captureType: results[i].captureType,
                              durchfuehrung: nil,
                              duengemittel: results[i].duengemittel,
                              mengeDuengemittel: results[i].mengeDuengemittel,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getPflanzenschutzObjects(type: String) -> Results<PflanzenschutzEntry> {
        
        return realm.objects(PflanzenschutzEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getPflanzenschutzEntries(results: Results<PflanzenschutzEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points: nil,
                              consumer: nil,
                              consumption: nil,
                              year: nil,
                              aspekt: nil,
                              kwh: nil,
                              power: nil,
                              runtime: nil,
                              description: nil,
                              user: results[i].Benutzer,
                              date: results[i].Datum,
                              field: results[i].Feld,
                              hours: results[i].Arbeitszeit,
                              captureType: results[i].captureType,
                              durchfuehrung: nil,
                              duengemittel: nil,
                              mengeDuengemittel: nil,
                              gegen: results[i].gegen,
                              mittel: results[i].mittel,
                              termin: results[i].termin,
                              info: results[i].info,
                              mengePflanzenschutzmittel: results[i].mengePflanzenschutzmittel)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getGeneralObjects(type: String) -> Results<GeneralEntry> {
        
        return realm.objects(GeneralEntry.self).filter("captureType = '" + type + "'")
    }
    
    func getGeneralEntries(results: Results<GeneralEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points: nil,
                              consumer: nil,
                              consumption: nil,
                              year: nil,
                              aspekt: nil,
                              kwh: nil,
                              power: nil,
                              runtime: nil,
                              description: nil,
                              user: results[i].Benutzer,
                              date: results[i].Datum,
                              field: results[i].Feld,
                              hours: results[i].Arbeitszeit,
                              captureType: results[i].captureType,
                              durchfuehrung: nil,
                              duengemittel: nil,
                              mengeDuengemittel: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    func deleteGeneral(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Benutzer = '" + entry.getUser() + "'"
        let feldArbeitszeit = "Feld = '" + entry.getField() + "' AND Arbeitszeit = '" + String(entry.getHours()) + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND Datum = '" + entry.getDate() + "'"
        
        let objects = realm.objects(GeneralEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    func deleteThermal(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Year = '" + entry.getYear() + "'"
        let feldArbeitszeit = "Description = '" + entry.getDescription() + "' AND Consumption = '" + entry.getConsumption() + "'"
        let query = typeBenutzer + " AND " + feldArbeitszeit
     
        
        let objects = realm.objects(ThermalEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    func deleteMaterial(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Year = '" + entry.getYear() + "'"
        let feldArbeitszeit = "Description = '" + entry.getDescription() + "' AND Consumption = '" + entry.getConsumption() + "'"
        let query = typeBenutzer + " AND " + feldArbeitszeit
        
        
        let objects = realm.objects(MaterialEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    func deleteEnergy(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Year = '" + entry.getYear() + "'"
        let feldArbeitszeit = "Consumptioner = '" + entry.getConsumptioner() + "' AND Aspekt = '" + entry.getAspekt() + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND kwh = '" + entry.getkwh() + " AND Leistung = " + entry.getLeistung() + "'"
        query += " AND Laufzeit = '" + entry.getLaufzeit()
        
        let objects = realm.objects(GeneralEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    func deleteTraubenlese(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Benutzer = '" + entry.getUser() + "'"
        let feldArbeitszeit = "Feld = '" + entry.getField() + "' AND Arbeitszeit = '" + String(entry.getHours()) + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND Datum = '" + entry.getDate() + "' AND durchfuehrung = '" + entry.getDurchfuehrung() + "'"
        
        let objects = realm.objects(TraubenleseEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    func deleteDuengung(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Benutzer = '" + entry.getUser() + "'"
        let feldArbeitszeit = "Feld = '" + entry.getField() + "' AND Arbeitszeit = '" + String(entry.getHours()) + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND Datum = '" + entry.getDate() + "'"
        query += " AND duengemittel = '" + entry.getDuengemittel() + "' AND mengeDuengemittel = '" + entry.getMengeDuengemittel() + "'"
        
        let objects = realm.objects(DuengungEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    func deleteArea(entry: Entry) {
        let typeName = "captureType = '" + entry.getCaptureType() + "' AND areaName = '" + entry.getAreaName() + "'"
        let points = "points = '" + entry.getAreaPoints() + "'"
        let query = typeName + " AND " + points
   
        let objects = realm.objects(AreaEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    func deletePflanzenschutz(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Benutzer = '" + entry.getUser() + "'"
        let feldArbeitszeit = "Feld = '" + entry.getField() + "' AND Arbeitszeit = '" + String(entry.getHours()) + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND Datum = '" + entry.getDate() + "'"
        query += " AND gegen = '" + entry.getGegen() + "' AND mittel = '" + entry.getMittel() + "'"
        query += " AND termin = '" + entry.getTermin() + "' AND info = '" + entry.getInfo() + "'"
        query += " AND mengePflanzenschutzmittel = '" + entry.getMengePflanzenschutzmittel() + "'"
        
        let objects = realm.objects(PflanzenschutzEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
}

class MaterialEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Year = ""
    @objc dynamic var Consumption = ""
    @objc dynamic var Description = ""
}

class ThermalEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Year = ""
    @objc dynamic var Consumption = ""
    @objc dynamic var Description = ""
}

class EnergyEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Year = ""
    @objc dynamic var Consumptioner = ""
    @objc dynamic var Aspekt = ""
    @objc dynamic var kwh = ""
    @objc dynamic var Leistung = ""
    @objc dynamic var Laufzeit = ""
}

class AreaEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var areaName = ""
    @objc dynamic var points = ""
}

class GeneralEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit = ""
    @objc dynamic var Datum = ""
}

class TraubenleseEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit = ""
    @objc dynamic var Datum = ""
    @objc dynamic var durchfuehrung = ""
}

class DuengungEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit = ""
    @objc dynamic var Datum = ""
    @objc dynamic var duengemittel = ""
    @objc dynamic var mengeDuengemittel = ""
}

class PflanzenschutzEntry: Object{
    @objc dynamic var captureType = ""
    @objc dynamic var Benutzer = ""
    @objc dynamic var Feld = ""
    @objc dynamic var Arbeitszeit = ""
    @objc dynamic var Datum = ""
    @objc dynamic var gegen = ""
    @objc dynamic var mittel = ""
    @objc dynamic var termin = ""
    @objc dynamic var info = ""
    @objc dynamic var mengePflanzenschutzmittel = ""
}
