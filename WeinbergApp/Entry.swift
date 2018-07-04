//
//  Entry.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 18.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import UIKit

struct Entry{

    var user: String
    var date: Date
    var field: String
    var hours: Double
    var captureType: String
    //speziell für Traubenlese
    var durchfuehrung: String?
    //speziell für Düngung
    var duengemittel: String?
    var mengeDuengemittel: Double?
    //speziell für Pflanzenschutz
    var gegen: String?
    var mittel: String?
    var termin: String?
    var info: String?
    var mengePflanzenschutzmittel: Double?
   
    
    public func getUser() -> String{
        return self.user
    }
    
    public func getDate() -> Date {
        return self.date
    }
    
    public func getField() -> String {
        return self.field
    }
    
    public func getHours() -> Double {
        return self.hours
    }
    
    public func getCaptureType() -> String {
        return self.captureType
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
    
    public func getMengeDuengemittel() -> Double {
        if let returnValue = self.mengeDuengemittel {
            return returnValue
        } else {
            return -1
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
    
    public func getMengePflanzenschutzmittel() -> Double {
        if let returnValue = self.mengePflanzenschutzmittel {
            return returnValue
        } else {
            return -1
        }
    }
    
    
    
    public mutating func setUser(user: String) {
        self.user = user
    }
    
    public mutating func setDate(date: Date) {
        self.date = date
    }
    
    public mutating func setField(field: String) {
        self.field = field
    }
    
    public mutating func setHours(hours: Double) {
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
    
    public mutating func setMengeDuengemittel(mengeDuengemittel: Double) {
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
    
    public mutating func setMengePflanzenschutzmittel(mengePflanzenschutzmittel: Double) {
        self.mengePflanzenschutzmittel = mengePflanzenschutzmittel
    }
}
