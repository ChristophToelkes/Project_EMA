//
//  AddEntryViewControllerTests.swift
//  WeinbergAppTests
//
//  Created by ema on 03.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest
@testable import WeinbergApp

class AddEntryViewControllerTests: XCTestCase {
    
    let db = RealmHelper()
    
    override func setUp() {
        super.setUp()
        db.addArea(areaName: "Testfeld", points: "37.7870006217123:-122.40844616956 37.7858123288451:-122.408519292926 37.7849852080355:-122.407545839962 37.785660630515:-122.406490123367 37.7867477951097:-122.407001985889 ", captureType: "Area", size: "33419")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        let entry = Entry(areaName: "Testfeld",
                          points: "37.7870006217123:-122.40844616956 37.7858123288451:-122.408519292926 37.7849852080355:-122.407545839962 37.785660630515:-122.406490123367 37.7867477951097:-122.407001985889 ",
                          areaSize: "33419",
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
                          captureType: "Area",
                          durchfuehrung: nil,
                          duengemittel: nil,
                          mengeDuengemittel: nil,
                          category: nil,
                          gegen: nil,
                          mittel: nil,
                          termin: nil,
                          info: nil,
                          mengePflanzenschutzmittel: nil)
        db.deleteArea(entry: entry)
    }
    
    func testAddEntryViewController() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddEntryViewControllerID") as! AddEntryViewController
        //when
        let view = sut.view
        //then
        XCTAssertTrue(view?.accessibilityLabel == "AddEntryView")
    }
    
    func testAddEntrySuccess() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddEntryViewControllerID") as! AddEntryViewController
        sut.captureType = "Entlauben"
        _ = sut.view
        
        sut.datePicker.date = Date(timeIntervalSinceReferenceDate: 0)
        sut.benutzerText.text = "TestNutzer"
        sut.arbeitszeitText.text = "12345"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date(timeIntervalSinceReferenceDate: 0))
        let field = sut.areas[sut.areaPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: nil, consumption: nil, year: nil, aspekt: nil, kwh: nil, power: nil, runtime: nil, description: nil, user: "TestNutzer", date: date, field: field, hours: "12345", captureType: "Entlauben", durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, category: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        //when
        sut.safeEntryBtn(sut.safeButton)
        //then
        var found = false;
        var result = db.loadObjects(type: "Entlauben")
        while !result.isEmpty {
            if result.first?.user == "TestNutzer" && result.first?.date == date && result.first?.field == field && result.first?.hours == "12345" && result.first?.captureType == "Entlauben" {
                found = true;
            }
            result.removeFirst()
        }
        db.deleteGeneral(entry: entry)
        XCTAssertTrue(found)
    }
    
    func testAddEntryUnsuccessfull() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddEntryViewControllerID") as! AddEntryViewController
        sut.captureType = "Entlauben"
        _ = sut.view
        
        sut.datePicker.date = Date(timeIntervalSinceReferenceDate: 0)
        sut.benutzerText.text = nil
        sut.arbeitszeitText.text = "12345"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date(timeIntervalSinceReferenceDate: 0))
        let field = sut.areas[sut.areaPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: nil, consumption: nil, year: nil, aspekt: nil, kwh: nil, power: nil, runtime: nil, description: nil, user: nil, date: date, field: field, hours: "12345", captureType: "Entlauben", durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, category: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        //when
        sut.safeEntryBtn(sut.safeButton)
        //then
        var notFound = true;
        var result = db.loadObjects(type: "Entlauben")
        while !result.isEmpty {
            if result.first?.user == nil && result.first?.date == date && result.first?.field == field && result.first?.hours == "12345" && result.first?.captureType == "Entlauben" {
                notFound = false;
            }
            result.removeFirst()
        }
        if !notFound {
            db.deleteGeneral(entry: entry)
        }
        XCTAssertTrue(notFound)
    }
    
    func testDeleteEntry() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddEntryViewControllerID") as! AddEntryViewController
        sut.captureType = "Entlauben"
        _ = sut.view
        
        sut.datePicker.date = Date(timeIntervalSinceReferenceDate: 0)
        sut.benutzerText.text = "TestNutzer"
        sut.arbeitszeitText.text = "12345"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date(timeIntervalSinceReferenceDate: 0))
        let field = sut.areas[sut.areaPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: nil, consumption: nil, year: nil, aspekt: nil, kwh: nil, power: nil, runtime: nil, description: nil, user: "TestNutzer", date: date, field: field, hours: "12345", captureType: "Entlauben", durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, category: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        
        sut.safeEntryBtn(sut.safeButton)
        sut.entry = entry
        //when
        sut.deleteEntry()
        //then
        var notFound = true;
        var result = db.loadObjects(type: "Entlauben")
        while !result.isEmpty {
            if result.first?.user == "TestNutzer" && result.first?.date == date && result.first?.field == field && result.first?.hours == "12345" && result.first?.captureType == "Entlauben" {
                notFound = false;
            }
            result.removeFirst()
        }
        XCTAssertTrue(notFound)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
