//
//  RealmHelperTests.swift
//  WeinbergAppTests
//
//  Created by ema on 31.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest
@testable import WeinbergApp

class RealmHelperTests: XCTestCase {
    
    var db: RealmHelper = RealmHelper()
    var entry: Entry?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddGeneral() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "test", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getGeneralEntries(results: db.getGeneralObjects(type: "test"))
        while !entries.isEmpty {
            db.deleteGeneral(entry: entry)
            entries = db.getGeneralEntries(results: db.getGeneralObjects(type: "test"))
        }
        //when
        db.addGeneral(captureType: "test", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test")
        //then
        entries = db.getGeneralEntries(results: db.getGeneralObjects(type: "test"))
        db.deleteGeneral(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testAddArea() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testArea", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getAreaEntries(results: db.getAreaObjects(type: "testArea"))
        while !entries.isEmpty {
            db.deleteArea(entry: entry)
            entries = db.getAreaEntries(results: db.getAreaObjects(type: "testArea"))
        }
        //when
        db.addArea(areaName: "test", points: "test", captureType: "testArea", size: "test")
        //then
        entries = db.getAreaEntries(results: db.getAreaObjects(type: "testArea"))
        db.deleteArea(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testAddThermal() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testThermal", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getThermalEntries(results: db.getThermalObjects(type: "testThermal"))
        while !entries.isEmpty {
            db.deleteThermal(entry: entry)
            entries = db.getThermalEntries(results: db.getThermalObjects(type: "testThermal"))
        }
        //when
        db.addThermal(year: "test", description: "test", Consumption: "test", captureType: "testThermal")
        //then
        entries = db.getThermalEntries(results: db.getThermalObjects(type: "testThermal"))
        db.deleteThermal(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testAddMaterial() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testMaterial", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getMaterialEntries(results: db.getMaterialObjects(type: "testMaterial"))
        while !entries.isEmpty {
            db.deleteMaterial(entry: entry)
            entries = db.getMaterialEntries(results: db.getMaterialObjects(type: "testMaterial"))
        }
        //when
        db.addMaterial(year: "test", description: "test", Consumption: "test", captureType: "testMaterial")
        //then
        entries = db.getMaterialEntries(results: db.getMaterialObjects(type: "testMaterial"))
        db.deleteMaterial(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testAddEnergy() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testEnergy", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getEnergyEntries(results: db.getEnergyObjects(type: "testEnergy"))
        while !entries.isEmpty {
            db.deleteEnergy(entry: entry)
            entries = db.getEnergyEntries(results: db.getEnergyObjects(type: "testEnergy"))
        }
        //when
        db.addEnergy(year: "test", Consumptioner: "test", aspekt: "test", captureType: "testEnergy", kwh: "test", power: "test", runtime: "test")
        //then
        entries = db.getEnergyEntries(results: db.getEnergyObjects(type: "testEnergy"))
        db.deleteEnergy(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testAddTraubenlese() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testTraubenlese", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getTraubenleseEntries(results: db.getTraubenleseObjects(type: "testTraubenlese"))
        while !entries.isEmpty {
            db.deleteTraubenlese(entry: entry)
            entries = db.getTraubenleseEntries(results: db.getTraubenleseObjects(type: "testTraubenlese"))
        }
        //when
        db.addTraubenlese(captureType: "testTraubenlese", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", durchfuehrung: "test")
        //then
        entries = db.getTraubenleseEntries(results: db.getTraubenleseObjects(type: "testTraubenlese"))
        db.deleteTraubenlese(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testAddDuengung() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testDuengung", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getDuengungEntries(results: db.getDuengungObjects(type: "testDuengung"))
        while !entries.isEmpty {
            db.deleteDuengung(entry: entry)
            entries = db.getDuengungEntries(results: db.getDuengungObjects(type: "testDuengung"))
        }
        //when
        db.addDuengung(captureType: "testDuengung", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test")
        //then
        entries = db.getDuengungEntries(results: db.getDuengungObjects(type: "testDuengung"))
        db.deleteDuengung(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testAddPflanzenschutz() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testPflanzenschutz", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        var entries = db.getPflanzenschutzEntries(results: db.getPflanzenschutzObjects(type: "testPflanzenschutz"))
        while !entries.isEmpty {
            db.deletePflanzenschutz(entry: entry)
            entries = db.getPflanzenschutzEntries(results: db.getPflanzenschutzObjects(type: "testPflanzenschutz"))
        }
        //when
        db.addPflanzenschutz(captureType: "testPflanzenschutz", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test", category: "test")
        //then
        entries = db.getPflanzenschutzEntries(results: db.getPflanzenschutzObjects(type: "testPflanzenschutz"))
        db.deletePflanzenschutz(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testLoadObjectsEmpty() {
        //given
        //when
        let entries = db.loadObjects(type: "blah")
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testLoadObjectsTraubenlese() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "Traubenlese", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addTraubenlese(captureType: "Traubenlese", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", durchfuehrung: "test")
        //when
        let entries = db.loadObjects(type: "Traubenlese")
        //then
        db.deleteTraubenlese(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testLoadObjectsDuengung() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "Düngung", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addDuengung(captureType: "Düngung", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test")
        //when
        let entries = db.loadObjects(type: "Düngung")
        //then
        db.deleteDuengung(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testLoadObjectsPflanzenschutz() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "Pflanzenschutz", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addPflanzenschutz(captureType: "Pflanzenschutz", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test", category: "test")
        //when
        let entries = db.loadObjects(type: "Pflanzenschutz")
        //then
        db.deletePflanzenschutz(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testLoadObjectsArea() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "Area", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addArea(areaName: "test", points: "test", captureType: "Area", size: "test")
        //when
        let entries = db.loadObjects(type: "Area")
        //then
        db.deleteArea(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testLoadObjectsStoffströme() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "Stoffströme", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addMaterial(year: "test", description: "test", Consumption: "test", captureType: "Stoffströme")
        //when
        let entries = db.loadObjects(type: "Stoffströme")
        //then
        db.deleteMaterial(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testLoadObjectsElektrischerAufwand() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "Elektrischer Aufwand", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addEnergy(year: "test", Consumptioner: "test", aspekt: "test", captureType: "Elektrischer Aufwand", kwh: "test", power: "test", runtime: "test")
        //when
        let entries = db.loadObjects(type: "Elektrischer Aufwand")
        //then
        db.deleteEnergy(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testLoadObjectsThermischerAufwand() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "Thermischer Aufwand", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addThermal(year: "test", description: "test", Consumption: "test", captureType: "Thermischer Aufwand")
        //when
        let entries = db.loadObjects(type: "Thermischer Aufwand")
        //then
        db.deleteThermal(entry: entry)
        XCTAssert(!entries.isEmpty)
    }
    
    func testDeleteGeneral() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "test", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addGeneral(captureType: "test", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test")
        var entries = db.getGeneralEntries(results: db.getGeneralObjects(type: "test"))
        //when
        while !entries.isEmpty {
            db.deleteGeneral(entry: entry)
            entries = db.getGeneralEntries(results: db.getGeneralObjects(type: "test"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testDeleteThermal() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testThermal", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addThermal(year: "test", description: "test", Consumption: "test", captureType: "testThermal")
        var entries = db.getThermalEntries(results: db.getThermalObjects(type: "testThermal"))
        //when
        while !entries.isEmpty {
            db.deleteThermal(entry: entry)
            entries = db.getThermalEntries(results: db.getThermalObjects(type: "testThermal"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testDeleteMaterial() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testMaterial", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addMaterial(year: "test", description: "test", Consumption: "test", captureType: "testMaterial")
        var entries = db.getMaterialEntries(results: db.getMaterialObjects(type: "testMaterial"))
        //when
        while !entries.isEmpty {
            db.deleteMaterial(entry: entry)
            entries = db.getMaterialEntries(results: db.getMaterialObjects(type: "testMaterial"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testDeleteEnergy() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testEnergy", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addEnergy(year: "test", Consumptioner: "test", aspekt: "test", captureType: "testEnergy", kwh: "test", power: "test", runtime: "test")
        var entries = db.getEnergyEntries(results: db.getEnergyObjects(type: "testEnergy"))
        //when
        while !entries.isEmpty {
            db.deleteEnergy(entry: entry)
            entries = db.getEnergyEntries(results: db.getEnergyObjects(type: "testEnergy"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testDeleteTraubenlese() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testTraubenlese", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addTraubenlese(captureType: "testTraubenlese", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", durchfuehrung: "test")
        var entries = db.getTraubenleseEntries(results: db.getTraubenleseObjects(type: "testTraubenlese"))
        //when
        while !entries.isEmpty {
            db.deleteTraubenlese(entry: entry)
            entries = db.getTraubenleseEntries(results: db.getTraubenleseObjects(type: "test"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testDeleteDuengung() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testDuengung", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addDuengung(captureType: "testDuengung", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test")
        var entries = db.getDuengungEntries(results: db.getDuengungObjects(type: "testDuengung"))
        //when
        while !entries.isEmpty {
            db.deleteDuengung(entry: entry)
            entries = db.getDuengungEntries(results: db.getDuengungObjects(type: "testDuengung"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testDeleteArea() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testArea", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addArea(areaName: "test", points: "test", captureType: "testArea", size: "test")
        var entries = db.getAreaEntries(results: db.getAreaObjects(type: "testArea"))
        //when
        while !entries.isEmpty {
            db.deleteArea(entry: entry)
            entries = db.getAreaEntries(results: db.getAreaObjects(type: "testArea"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testDeletePflanzenschutz() {
        //given
        let entry = Entry(areaName: "test", points: "test", areaSize: "test", consumer: "test", consumption: "test", year: "test", aspekt: "test", kwh: "test", power: "test", runtime: "test", description: "test", user: "test", date: "test", field: "test", hours: "test", captureType: "testPflanzenschutz", durchfuehrung: "test", duengemittel: "test", mengeDuengemittel: "test", category: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test")
        db.addPflanzenschutz(captureType: "testPflanzenschutz", benutzer: "test", feld: "test", arbeitszeit: "test", datum: "test", gegen: "test", mittel: "test", termin: "test", info: "test", mengePflanzenschutzmittel: "test", category: "test")
        var entries = db.getPflanzenschutzEntries(results: db.getPflanzenschutzObjects(type: "testPflanzenschutz"))
        //when
        while !entries.isEmpty {
            db.deletePflanzenschutz(entry: entry)
            entries = db.getPflanzenschutzEntries(results: db.getPflanzenschutzObjects(type: "testPflanzenschutz"))
        }
        //then
        XCTAssert(entries.isEmpty)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        //self.measure {
            // Put the code you want to measure the time of here.
        //}
    }
    
}
