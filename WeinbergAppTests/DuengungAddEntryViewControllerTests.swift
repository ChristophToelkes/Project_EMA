//
//  DuengungAddEntryViewControllerTests.swift
//  WeinbergAppTests
//
//  Created by ema on 03.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest
@testable import WeinbergApp

class DuengungAddEntryViewControllerTests: XCTestCase {
    
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
    
    func testDuengungAddEntryViewController() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "DuengungAddEntryViewControllerID") as! DuengungAddEntryViewController
        //when
        let view = sut.view
        //then
        XCTAssertTrue(view?.accessibilityLabel == "DuengungView")
    }
    
    func testAddEntrySuccess() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "DuengungAddEntryViewControllerID") as! DuengungAddEntryViewController
        sut.captureType = "Düngung"
        _ = sut.view
        
        sut.datePicker.date = Date(timeIntervalSinceReferenceDate: 0)
        sut.benutzerText.text = "TestNutzer"
        sut.arbeitszeitText.text = "12345"
        sut.category = "Organisch"
        sut.duengemittelText.text = "Testmittel"
        sut.mengeDuengemittelText.text = "234"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date(timeIntervalSinceReferenceDate: 0))
        let field = sut.areas[sut.areaPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: nil, consumption: nil, year: nil, aspekt: nil, kwh: nil, power: nil, runtime: nil, description: nil, user: "TestNutzer", date: date, field: field, hours: "12345", captureType: "Düngung", durchfuehrung: nil, duengemittel: "Testmittel", mengeDuengemittel: "234", category: "Organisch", gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        //when
        sut.safeEntryBtn(sut.headCaptureLabel)
        //then
        var found = false;
        var result = db.loadObjects(type: "Düngung")
        while !result.isEmpty {
            if result.first?.user == "TestNutzer" && result.first?.date == date && result.first?.field == field && result.first?.hours == "12345" && result.first?.captureType == "Düngung" && result.first?.category == "Organisch" && result.first?.duengemittel == "Testmittel" && result.first?.mengeDuengemittel == "234" {
                found = true;
            }
            result.removeFirst()
        }
        db.deleteDuengung(entry: entry)
        XCTAssertTrue(found)
    }
    
    func testAddEntryUnsuccessfull() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "DuengungAddEntryViewControllerID") as! DuengungAddEntryViewController
        sut.captureType = "Düngung"
        _ = sut.view
        
        sut.datePicker.date = Date(timeIntervalSinceReferenceDate: 0)
        sut.benutzerText.text = nil
        sut.arbeitszeitText.text = "12345"
        sut.category = "Organisch"
        sut.duengemittelText.text = "Testmittel"
        sut.mengeDuengemittelText.text = "234"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date(timeIntervalSinceReferenceDate: 0))
        let field = sut.areas[sut.areaPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: nil, consumption: nil, year: nil, aspekt: nil, kwh: nil, power: nil, runtime: nil, description: nil, user: nil, date: date, field: field, hours: "12345", captureType: "Düngung", durchfuehrung: nil, duengemittel: "Testmittel", mengeDuengemittel: "234", category: "Organisch", gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        //when
        sut.safeEntryBtn(sut.headCaptureLabel)
        //then
        var notFound = true;
        var result = db.loadObjects(type: "Düngung")
        while !result.isEmpty {
            if result.first?.user == nil && result.first?.date == date && result.first?.field == field && result.first?.hours == "12345" && result.first?.captureType == "Düngung" && result.first?.category == "Organisch" && result.first?.duengemittel == "Testmittel" && result.first?.mengeDuengemittel == "234" {
                notFound = false;
            }
            result.removeFirst()
        }
        if !notFound {
            db.deleteDuengung(entry: entry)
        }
        
        XCTAssertTrue(notFound)
    }
    
    func testDeleteEntry() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "DuengungAddEntryViewControllerID") as! DuengungAddEntryViewController
        sut.captureType = "Düngung"
        _ = sut.view
        
        sut.datePicker.date = Date(timeIntervalSinceReferenceDate: 0)
        sut.benutzerText.text = "TestNutzer"
        sut.arbeitszeitText.text = "12345"
        sut.category = "Organisch"
        sut.duengemittelText.text = "Testmittel"
        sut.mengeDuengemittelText.text = "234"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date(timeIntervalSinceReferenceDate: 0))
        let field = sut.areas[sut.areaPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: nil, consumption: nil, year: nil, aspekt: nil, kwh: nil, power: nil, runtime: nil, description: nil, user: "TestNutzer", date: date, field: field, hours: "12345", captureType: "Düngung", durchfuehrung: nil, duengemittel: "Testmittel", mengeDuengemittel: "234", category: "Organisch", gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        
        sut.safeEntryBtn(sut.headCaptureLabel)
        sut.entry = entry
        //when
        sut.deleteEntry()
        //then
        var notFound = true;
        var result = db.loadObjects(type: "Düngung")
        while !result.isEmpty {
            if result.first?.user == "TestNutzer" && result.first?.date == date && result.first?.field == field && result.first?.hours == "12345" && result.first?.captureType == "Düngung" && result.first?.category == "Organisch" && result.first?.duengemittel == "Testmittel" && result.first?.mengeDuengemittel == "234" {
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
