//
//  AddElectricalEquipmentViewControllerTests.swift
//  WeinbergAppTests
//
//  Created by ema on 03.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest
@testable import WeinbergApp

class AddElectricalEquipmentViewControllerTests: XCTestCase {
    
    let db = RealmHelper()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddElectricalEquipmentViewController() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddElectricalEquipmentViewControllerID") as! AddElectricalEquipmentViewController
        //when
        let view = sut.view
        //then
        XCTAssertTrue(view?.accessibilityLabel == "AddElectricalView")
    }
    
    func testAddEntrySuccess() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddElectricalEquipmentViewControllerID") as! AddElectricalEquipmentViewController
        sut.captureType = "Elektrischer Aufwand"
        _ = sut.view
        
        sut.yearTestField.text = "2000"
        sut.consumerTextField.text = "TestConsumer"
        sut.kwhTestField.text = "234"
        
        
        let aspekt =  sut.options[sut.optionPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: "TestConsumer", consumption: nil, year: "2000", aspekt: aspekt, kwh: "234", power: nil, runtime: nil, description: nil, user: nil, date: nil, field: nil, hours: nil, captureType: "Elektrischer Aufwand", durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, category: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        //when
        sut.addBtn(sut.kwhLabel)
        //then
        var found = false;
        var result = db.loadObjects(type: "Elektrischer Aufwand")
        while !result.isEmpty {
            if result.first?.aspekt == aspekt && result.first?.year == "2000" && result.first?.consumer == "TestConsumer" && result.first?.kwh == "234" && result.first?.captureType == "Elektrischer Aufwand" {
                found = true;
            }
            result.removeFirst()
        }
        db.deleteEnergy(entry: entry)
        XCTAssertTrue(found)
    }
    
    func testAddEntryUnsuccessfull() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddElectricalEquipmentViewControllerID") as! AddElectricalEquipmentViewController
        sut.captureType = "Elektrischer Aufwand"
        _ = sut.view
        
        sut.yearTestField.text = nil
        sut.consumerTextField.text = "TestConsumer"
        sut.kwhTestField.text = "234"
        
        let aspekt =  sut.options[sut.optionPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: "TestConsumer", consumption: nil, year: nil, aspekt: aspekt, kwh: "234", power: nil, runtime: nil, description: nil, user: nil, date: nil, field: nil, hours: nil, captureType: "Elektrischer Aufwand", durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, category: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        //when
        sut.addBtn(sut.kwhLabel)
        //then
        var notFound = true;
        var result = db.loadObjects(type: "Elektrischer Aufwand")
        while !result.isEmpty {
            if result.first?.aspekt == aspekt && result.first?.year == nil && result.first?.consumer == "TestConsumer" && result.first?.kwh == "234" && result.first?.captureType == "Elektrischer Aufwand" {
                notFound = false;
            }
            result.removeFirst()
        }
        if !notFound {
            db.deleteEnergy(entry: entry)
        }
        XCTAssertTrue(notFound)
    }
    
    func testDeleteEntry() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddElectricalEquipmentViewControllerID") as! AddElectricalEquipmentViewController
        sut.captureType = "Elektrischer Aufwand"
        _ = sut.view
        
        sut.yearTestField.text = "2000"
        sut.consumerTextField.text = "TestConsumer"
        sut.kwhTestField.text = "234"
        
        
        let aspekt =  sut.options[sut.optionPicker.selectedRow(inComponent: 0)]
        
        let entry = Entry(areaName: nil, points: nil, areaSize: nil, consumer: "TestConsumer", consumption: nil, year: "2000", aspekt: aspekt, kwh: "234", power: nil, runtime: nil, description: nil, user: nil, date: nil, field: nil, hours: nil, captureType: "Elektrischer Aufwand", durchfuehrung: nil, duengemittel: nil, mengeDuengemittel: nil, category: nil, gegen: nil, mittel: nil, termin: nil, info: nil, mengePflanzenschutzmittel: nil)
        
        sut.addBtn(sut.kwhLabel)
        sut.entry = entry
        //when
        sut.deleteEntry()
        //then
        var notFound = true;
        var result = db.loadObjects(type: "Elektrischer Aufwand")
        while !result.isEmpty {
            if result.first?.aspekt == aspekt && result.first?.year == "2000" && result.first?.consumer == "TestConsumer" && result.first?.kwh == "234" && result.first?.captureType == "Elektrischer Aufwand" {
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
