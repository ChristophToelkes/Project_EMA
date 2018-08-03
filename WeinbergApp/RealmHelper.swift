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
    
    /// Fügt der Datenbank einen generellen Eintrag hinzu.
    ///
    /// - Parameters:
    ///   - captureType: Der CaptureType des Eintrags
    ///   - benutzer: Der zugewiesene Benutzer des Eintrags
    ///   - feld: Das zugewiesene Feld des Eintrags
    ///   - arbeitszeit: Die Dauer des Eintrags
    ///   - datum: Das Datum des Eintrags
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
    
    /// Fügt der Datenbank ein neues Feld hinzu.
    ///
    /// - Parameters:
    ///   - areaName: Der Name des Feldes
    ///   - points: Die Koordinaten des Feldes
    ///   - captureType: Der CaptureType des Feldes
    ///   - size: Die Größe des Feldes
    func addArea(areaName: String, points: String, captureType: String, size: String) {
        
        let newEntry = AreaEntry()
        newEntry.captureType = captureType
        newEntry.areaName = areaName
        newEntry.points = points
        newEntry.areaSize = size
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    /// Fügt der Datenbank einen neuen Eintrag für Thermischen Aufwand hinzu
    ///
    /// - Parameters:
    ///   - year: Das zugewiesene Jahr des Eintrags
    ///   - description: Die Beschreibung des Eintrags
    ///   - Consumption: Der zugewiesene Verbrauch des Eintrags
    ///   - captureType: Der CaptureType des Eintrags
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
    
    /// Fügt der Datenbank einen neuen Eintrag für Stoffströme hinzu.
    ///
    /// - Parameters:
    ///   - year: Das zugewiesene Jahr des Eintrags
    ///   - description: Die Beschreibung des Eintrags
    ///   - Consumption: Der zugewiesene Verbrauch des Eintrags
    ///   - captureType: Der CaptureType des Eintrags
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
    
    /// Fügt der Datenbank einen neuen Eintrag für elektrischen Aufwand hinzu.
    ///
    /// - Parameters:
    ///   - year: Das zugewiesene Jahr des Eintrags
    ///   - Consumptioner: Der zugewiesene Verbraucher des Eintrags
    ///   - aspekt: Der zugewiesene Energieverbrauchsgrund des Eintrags
    ///   - captureType: Der CaptureType des Eintrags
    ///   - kwh: Der zugewiesene Verbrauch des Eintrags in kwh
    ///   - power: Die zugewiesene Leistung des Eintrags in PS
    ///   - runtime: Die zugewiesene Laufzeit des Eintrags in h
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
    
    /// Fügt der Datenbank einen neuen Eintrag für Traubenlese hinzu.
    ///
    /// - Parameters:
    ///   - captureType: Der zugewiesene CaptureType des Eintrags
    ///   - benutzer: Der zugewiesene Benutzer des Eintrags
    ///   - feld: Das zugewiesene Feld es Eintrags
    ///   - arbeitszeit: Die Dauer des Eintrags in h
    ///   - datum: Das zugewiesene Datum des Arbeitsvorgangs
    ///   - durchfuehrung: Die beschriebene Durchführung des Arbeitsvorgangs
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
    
    /// Fügt der Datenbank einen neuen Eintrag für Düngung hinzu.
    ///
    /// - Parameters:
    ///   - captureType: Der CaptureType des Eintrags
    ///   - benutzer: Der zugewiesene Benutzer des Eintrags
    ///   - feld: Das zu düngende Feld
    ///   - arbeitszeit: Die Dauer des Vorgangs
    ///   - datum: Das zugewiesene Datum des Arbeitsvorgangs
    ///   - duengemittel: Das gewählte Düngemittel
    ///   - mengeDuengemittel: Die Menge des gewählten Düngemittels in kg/ha
    ///   - category: Die Kategorie des Düngemittels
    func addDuengung(captureType: String, benutzer: String, feld: String, arbeitszeit: String, datum: String, duengemittel: String, mengeDuengemittel: String, category: String) {

        
        let newEntry = DuengungEntry()
        newEntry.captureType = captureType
        newEntry.Benutzer = benutzer
        newEntry.Feld = feld
        newEntry.Arbeitszeit = arbeitszeit
        newEntry.Datum = datum
        newEntry.duengemittel = duengemittel
        newEntry.mengeDuengemittel = mengeDuengemittel
        newEntry.category = category
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    /// Fügt der Datenbank einen neuen Eintrag für Pflanzenschutz hinzu.
    ///
    /// - Parameters:
    ///   - captureType: Der CaptureType des Eintrags
    ///   - benutzer: Der zugewiesene benutzer des Eintrags
    ///   - feld: das zugewiesene Feld des Eintrags
    ///   - arbeitszeit: Die Dauer des Arbeitsvorgangs
    ///   - datum: Das Datum des Arbeitsvorgangs
    ///   - gegen: Der Schädling, gegen den die Pflanzen geschützt werden sollen
    ///   - mittel: Das Mittel, mit dem die Pflanzen geschützt werden sollen
    ///   - termin: Der Termin, an dem das Mittel ausgetragen werden soll
    ///   - info: Informationen zum Vorgang
    ///   - mengePflanzenschutzmittel: Die Menge des Pflanzenschutzmittels in kg/ha
    ///   - category: Die Kategorie des Pflanzenschutzmittels
    func addPflanzenschutz(captureType: String, benutzer: String, feld: String, arbeitszeit: String, datum: String, gegen: String, mittel: String, termin: String, info: String, mengePflanzenschutzmittel: String, category: String) {
        
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
        newEntry.category = category
        
        try! realm.write {
            realm.add(newEntry)
        }
    }
    
    /// Fordert die, in der Datenbank gespeicherten, Einträge in Abhängigkeit des CaptureTypes an.
    ///
    /// - Parameter type: Der CaptureType der Einträge
    /// - Returns: Ein Array von Einträgen
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
            entries = getGeneralEntries(results: getGeneralObjects(type: type))
        }
        return entries
    }
    
    /// Fordert die Einträge der Stoffströme aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von Stoffströmen
    func getMaterialObjects(type: String) -> Results<MaterialEntry> {
        
        return realm.objects(MaterialEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die Einträge der Stoffströme und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet der Stoffströme aus der Datenbank
    /// - Returns: Das Array der Einträge der Stoffströme
    func getMaterialEntries(results: Results<MaterialEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              areaSize: nil,
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
                              category: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Fordert die Einträge der Thermischen Aufwände aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von Thermischen Aufwänden
    func getThermalObjects(type: String) -> Results<ThermalEntry> {
        
        return realm.objects(ThermalEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die Einträge der Thermischen Aufwände und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet der Thermischen Aufwände aus der Datenbank
    /// - Returns: Das Array der Einträge der Thermischen Aufwände
    func getThermalEntries(results: Results<ThermalEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              areaSize: nil,
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
                              category: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Fordert die Einträge der Energetischen Aufwände aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von Energetischen Aufwänden
    func getEnergyObjects(type: String) -> Results<EnergyEntry> {
        
        return realm.objects(EnergyEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die Einträge der Energetischen Aufwände und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet der Energetischen Aufwände aus der Datenbank
    /// - Returns: Das Array der Einträge der Energetischen Aufwände
    func getEnergyEntries(results: Results<EnergyEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              areaSize: nil,
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
                              category: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Fordert die Einträge der Traubenlese aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von Traubenlese Einträgen
    func getTraubenleseObjects(type: String) -> Results<TraubenleseEntry> {
        
        return realm.objects(TraubenleseEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die Einträge der Traubenlese und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet der Traubenlese aus der Datenbank
    /// - Returns: Das Array der Einträge der Traubenlese
    func getTraubenleseEntries(results: Results<TraubenleseEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points:nil,
                              areaSize: nil,
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
                              category: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Fordert die Einträge der Felder aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von Feld Einträgen
    func getAreaObjects(type: String) -> Results<AreaEntry> {
        
        return realm.objects(AreaEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die Einträge der Felder und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet der Felder aus der Datenbank
    /// - Returns: Das Array der Einträge der Felder
    func getAreaEntries(results: Results<AreaEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: results[i].areaName,
                              points: results[i].points,
                              areaSize: results[i].areaSize,
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
                              category: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Fordert die Einträge der Duengung aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von Duengung Einträgen
    func getDuengungObjects(type: String) -> Results<DuengungEntry> {
        
        return realm.objects(DuengungEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die Einträge der Duengung und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet der Duengung aus der Datenbank
    /// - Returns: Das Array der Einträge der Duengung
    func getDuengungEntries(results: Results<DuengungEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points: nil,
                              areaSize: nil,
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
                              category: results[i].category,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Fordert die Einträge des Pflanzenschutzes aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von Pflanzenschutz Einträgen
    func getPflanzenschutzObjects(type: String) -> Results<PflanzenschutzEntry> {
        
        return realm.objects(PflanzenschutzEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die Einträge des Pflanzenschutzes und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet des Pflanzenschutzes aus der Datenbank
    /// - Returns: Das Array der Einträge des Pflanzenschutzes
    func getPflanzenschutzEntries(results: Results<PflanzenschutzEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points: nil,
                              areaSize: nil,
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
                              category: results[i].category,
                              gegen: results[i].gegen,
                              mittel: results[i].mittel,
                              termin: results[i].termin,
                              info: results[i].info,
                              mengePflanzenschutzmittel: results[i].mengePflanzenschutzmittel)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Fordert die generellen Einträge aus der Datenbank an.
    ///
    /// - Parameter type: Der angeforderte CaptureType
    /// - Returns: Ein ResultSet von generellen Einträgen
    func getGeneralObjects(type: String) -> Results<GeneralEntry> {
        
        return realm.objects(GeneralEntry.self).filter("captureType = '" + type + "'")
    }
    
    /// Erstellt die generellen Einträge und gibt diese zurück.
    ///
    /// - Parameter results: Das ResultSet aus der Datenbank
    /// - Returns: Das Array der generellen Einträge
    func getGeneralEntries(results: Results<GeneralEntry>) -> [Entry] {
        var entries: [Entry] = []
        
        for i in 0..<results.count {
            let entry = Entry(areaName: nil,
                              points: nil,
                              areaSize: nil,
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
                              category: nil,
                              gegen: nil,
                              mittel: nil,
                              termin: nil,
                              info: nil,
                              mengePflanzenschutzmittel: nil)
            entries.append(entry)
        }
        
        return entries
    }
    
    /// Löscht einen generellen Eintrag aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
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
    
    /// Löscht einen Eintrag zu Thermischem Aufwand aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
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
    
    /// Löscht einen Eintrag zu Stoffströmen aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
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
    
    /// Löscht einen Eintrag zu Energetischem Aufwand aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
    func deleteEnergy(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Year = '" + entry.getYear() + "'"
        let feldArbeitszeit = "Consumptioner = '" + entry.getConsumptioner() + "' AND Aspekt = '" + entry.getAspekt() + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND kwh = '" + entry.getkwh() + "' AND Leistung = '" + entry.getLeistung() + "'"
        query += " AND Laufzeit = '" + entry.getLaufzeit() + "'"
        
        let objects = realm.objects(EnergyEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    /// Löscht einen Eintrag zu Traubenlese aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
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
    
    /// Löscht einen Eintrag zu Duengung aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
    func deleteDuengung(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Benutzer = '" + entry.getUser() + "'"
        let feldArbeitszeit = "Feld = '" + entry.getField() + "' AND Arbeitszeit = '" + String(entry.getHours()) + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND Datum = '" + entry.getDate() + "' AND category = '" + entry.getCategory() + "'"
        query += " AND duengemittel = '" + entry.getDuengemittel() + "' AND mengeDuengemittel = '" + entry.getMengeDuengemittel() + "'"
        
        let objects = realm.objects(DuengungEntry.self).filter(query)
        
        let object = objects.first
        try! realm.write {
            realm.delete(object!)
        }
    }
    
    /// Löscht einen Eintrag eines Feldes aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
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
    
    /// Löscht einen Eintrag zu Pflanzenschutz aus der Datenbank, falls dieser gefunden wird.
    ///
    /// - Parameter entry: Der zu löschende Eintrag
    func deletePflanzenschutz(entry: Entry) {
        let typeBenutzer = "captureType = '" + entry.getCaptureType() + "' AND Benutzer = '" + entry.getUser() + "'"
        let feldArbeitszeit = "Feld = '" + entry.getField() + "' AND Arbeitszeit = '" + String(entry.getHours()) + "'"
        var query = typeBenutzer + " AND " + feldArbeitszeit
        query += " AND Datum = '" + entry.getDate() + "'"
        query += " AND gegen = '" + entry.getGegen() + "' AND mittel = '" + entry.getMittel() + "'"
        query += " AND termin = '" + entry.getTermin() + "' AND info = '" + entry.getInfo() + "'"
        query += " AND mengePflanzenschutzmittel = '" + entry.getMengePflanzenschutzmittel() + "' AND category = '" + entry.getCategory() + "'"
        
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
    @objc dynamic var areaSize = ""
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
    @objc dynamic var category = ""
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
    @objc dynamic var category = ""
}
