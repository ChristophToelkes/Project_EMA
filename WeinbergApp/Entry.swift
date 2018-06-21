//
//  Entry.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 18.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import UIKit

struct Entry{

    private var user: String
    private var date: String
    private var field: String
    private var hours: Double
    private var captureType: String
   
  
    public func getUser() -> String{
        return self.user
    }
    
    public func getDate() -> String {
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
    
    
    
    
    public mutating func setUser(user: String) {
        self.user = user
    }
    
    public mutating func setDate(date: String) {
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
}
