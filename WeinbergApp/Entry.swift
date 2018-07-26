//
//  Entry.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 18.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import UIKit


struct Entry{
    
    //Erfassung von Feldern
    var areaName: String?
    var points: String?
    
    //Thermale und Stoffströme
    var consumer: String?
    var consumption: String?
    var year: String?
    var aspekt: String?
    var kwh: String?
    var power: String?
    var runtime: String?
    var description: String?

    //Erfassung von Arbeiten
    var user: String?
    var date: String?
    var field: String?
    var hours: String?
    var captureType: String?
    //speziell für Traubenlese
    var durchfuehrung: String?
    //speziell für Düngung
    var duengemittel: String?
    var mengeDuengemittel: String?
    //speziell für Pflanzenschutz
    var gegen: String?
    var mittel: String?
    var termin: String?
    var info: String?
    var mengePflanzenschutzmittel: String?
    
    public func getConsumptioner() -> String{
        if let returnValue = self.consumer {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getConsumption() -> String{
        if let returnValue = self.consumption {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getYear() -> String{
        if let returnValue = self.year {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getkwh() -> String{
        if let returnValue = self.kwh {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getLeistung() -> String{
        if let returnValue = self.power {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getLaufzeit() -> String{
        if let returnValue = self.runtime {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getAspekt() -> String{
        if let returnValue = self.aspekt {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getDescription() -> String{
        if let returnValue = self.description {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getAreaName() -> String{
        if let returnValue = self.areaName {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getAreaPoints() -> String {
        if let returnValue = self.points {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getUser() -> String{
        if let returnValue = self.user {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getDate() -> String {
        if let returnValue = self.date {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getField() -> String {
        if let returnValue = self.field{
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getHours() -> String {
        if let returnValue = self.hours {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getCaptureType() -> String {
        if let returnValue = self.captureType{
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getDurchfuehrung() -> String {
        if let returnValue = self.durchfuehrung {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getDuengemittel() -> String {
        if let returnValue = self.duengemittel {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getMengeDuengemittel() -> String {
        if let returnValue = self.mengeDuengemittel {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getGegen() -> String {
        if let returnValue = self.gegen {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getMittel() -> String {
        if let returnValue = self.mittel {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getTermin() -> String {
        if let returnValue = self.termin {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getInfo() -> String {
        if let returnValue = self.info {
            return returnValue
        } else {
            return ""
        }
    }
    
    public func getMengePflanzenschutzmittel() -> String {
        if let returnValue = self.mengePflanzenschutzmittel {
            return returnValue
        } else {
            return ""
        }
    }
    
    public mutating func setLeistung(power: String) {
        self.power = power
    }
    
    public mutating func setLaufzeit(runtime: String) {
        self.runtime = runtime
    }
    
    public mutating func setConsumptioner(consumer: String) {
        self.consumer = consumer
    }
    
    public mutating func setConsumption(consumption: String) {
        self.consumption = consumption
    }
    
    public mutating func setYear(year: String) {
        self.year = year
    }
    
    public mutating func setKwf(kwh: String) {
        self.kwh = kwh
    }
    
    public mutating func setDescription(description: String) {
        self.description = description
    }
    
    public mutating func setAspekt(aspekt: String) {
        self.aspekt = aspekt
    }
    
    public mutating func setAreaName(areaName: String) {
        self.areaName = areaName
    }
    
    public mutating func setAreaPoints(points: String) {
        self.points = points
    }
    
    public mutating func setUser(user: String) {
        self.user = user
    }
    
    public mutating func setDate(date: String) {
        self.date = date
    }
    
    public mutating func setField(field: String) {
        self.field = field
    }
    
    public mutating func setHours(hours: String) {
        self.hours = hours
    }
    
    public mutating func setCaptureType(captureType: String){
        self.captureType = captureType
    }
    
    public mutating func setDurchfuehrung(durchfuehrung: String) {
        self.durchfuehrung = durchfuehrung
    }
    
    public mutating func setDuengemittel(duengemittel: String) {
        self.duengemittel = duengemittel
    }
    
    public mutating func setMengeDuengemittel(mengeDuengemittel: String) {
        self.mengeDuengemittel = mengeDuengemittel
    }
    
    public mutating func setGegen(gegen: String) {
        self.gegen = gegen
    }
    
    public mutating func setMittel(mittel: String) {
        self.mittel = mittel
    }
    
    public mutating func setTermin(termin: String) {
        self.termin = termin
    }
    
    public mutating func setInfo(info: String) {
        self.info = info
    }
    
    public mutating func setMengePflanzenschutzmittel(mengePflanzenschutzmittel: String) {
        self.mengePflanzenschutzmittel = mengePflanzenschutzmittel
    }
}
