//
//  MapViewControllerTests.swift
//  WeinbergAppUITests
//
//  Created by ema on 02.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest

class MapViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogout() {
        //given
        let app = XCUIApplication()
        let element = app.otherElements["LoginView"].children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        let textField = element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        textField.tap()
        textField.typeText("Max M")
        
        let secureTextField = element.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("1234")
        app/*@START_MENU_TOKEN@*/.buttons["Anmelden"]/*[[".otherElements[\"LoginView\"].buttons[\"Anmelden\"]",".buttons[\"Anmelden\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //when
        app/*@START_MENU_TOKEN@*/.buttons["abmelden"]/*[[".otherElements[\"MapView\"].buttons[\"abmelden\"]",".buttons[\"abmelden\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //given
        XCTAssertTrue(app.otherElements["LoginView"].exists)
        
    }
    // NOT WORKING
    func testAddField() {
        
        let app = XCUIApplication()
        var element = app.otherElements["LoginView"].children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        var textField = element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        textField.tap()
        textField.typeText("Max M")
        textField = element.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
        textField.tap()
        textField.typeText("1234")
        app/*@START_MENU_TOKEN@*/.buttons["Anmelden"]/*[[".otherElements[\"LoginView\"].buttons[\"Anmelden\"]",".buttons[\"Anmelden\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["+ Fläche"]/*[[".otherElements[\"MapView\"]",".buttons[\"+ Fläche\"].staticTexts[\"+ Fläche\"]",".staticTexts[\"+ Fläche\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"Financial District").element.press(forDuration: 1.3);/*[[".otherElements[\"MapView\"]",".maps.containing(.other, identifier:\"Monarch\").element",".tap()",".press(forDuration: 1.3);",".maps.containing(.other, identifier:\"Burlington Coat Factory\").element",".maps.containing(.other, identifier:\"Zero Zero\").element",".maps.containing(.other, identifier:\"Blue Bottle Cafe\").element",".maps.containing(.other, identifier:\"The Warfield\").element",".maps.containing(.other, identifier:\"Children’s Creativity Museum\").element",".maps.containing(.other, identifier:\"The Moscone Center\").element",".maps.containing(.other, identifier:\"The Melt\").element",".maps.containing(.other, identifier:\"Nordstrom Rack\").element",".maps.containing(.other, identifier:\"Westfield San Francisco Centre\").element",".maps.containing(.other, identifier:\"Metreon\").element",".maps.containing(.other, identifier:\"Market & Powell\").element",".maps.containing(.other, identifier:\"Parc 55 San Francisco - A Hilton Hotel\").element",".maps.containing(.other, identifier:\"San Francisco Marriott Marquis\").element",".maps.containing(.other, identifier:\"Powell St\").element",".maps.containing(.other, identifier:\"Yerba Buena Center for the Arts\").element",".maps.containing(.other, identifier:\"Hotel Nikko San Francisco\").element",".maps.containing(.other, identifier:\"Contemporary Jewish Museum\").element",".maps.containing(.other, identifier:\"The St. Regis San Francisco\").element",".maps.containing(.other, identifier:\"Hotel Spero\").element",".maps.containing(.other, identifier:\"Fashion Institute of Design & Merchandising - San Francisco Campus\").element",".maps.containing(.other, identifier:\"The Marker San Francisco\").element",".maps.containing(.other, identifier:\"Curran\").element",".maps.containing(.other, identifier:\"Museum of Ice Cream\").element",".maps.containing(.other, identifier:\"Novela\").element",".maps.containing(.other, identifier:\"Neiman Marcus\").element",".maps.containing(.other, identifier:\"Palace Hotel\").element",".maps.containing(.other, identifier:\"JW Marriott Hotel\").element",".maps.containing(.other, identifier:\"Saks Fifth Avenue\").element",".maps.containing(.other, identifier:\"Montgomery St\").element",".maps.containing(.other, identifier:\"Zara\").element",".maps.containing(.other, identifier:\"7-Eleven\").element",".maps.containing(.other, identifier:\"Galleria Park Hotel\").element",".maps.containing(.other, identifier:\"White House Garage\").element",".maps.containing(.other, identifier:\"Osaka University North American Center for Academic Initiatives\").element",".maps.containing(.other, identifier:\"Tacorea\").element",".maps.containing(.other, identifier:\"Sutter Stockton Garage\").element",".maps.containing(.other, identifier:\"US Post Office\").element",".maps.containing(.other, identifier:\"Pagan Idol\").element",".maps.containing(.other, identifier:\"Dragon Gate\").element",".maps.containing(.other, identifier:\"The Ritz-Carlton\").element",".maps.containing(.other, identifier:\"Financial District\").element"],[[[-1,44,2],[-1,43,2],[-1,42,2],[-1,41,2],[-1,40,2],[-1,39,2],[-1,38,2],[-1,37,2],[-1,36,2],[-1,35,2],[-1,34,2],[-1,33,2],[-1,32,2],[-1,31,2],[-1,30,2],[-1,29,2],[-1,28,2],[-1,27,2],[-1,26,2],[-1,25,2],[-1,24,2],[-1,23,2],[-1,22,2],[-1,21,2],[-1,20,2],[-1,19,2],[-1,18,2],[-1,17,2],[-1,16,2],[-1,15,2],[-1,14,2],[-1,13,2],[-1,12,2],[-1,11,2],[-1,10,2],[-1,9,2],[-1,8,2],[-1,7,2],[-1,6,2],[-1,5,2],[-1,4,2],[-1,1,2],[-1,0,1]],[[-1,44,2],[-1,43,2],[-1,42,2],[-1,41,2],[-1,40,2],[-1,39,2],[-1,38,2],[-1,37,2],[-1,36,2],[-1,35,2],[-1,34,2],[-1,33,2],[-1,32,2],[-1,31,2],[-1,30,2],[-1,29,2],[-1,28,2],[-1,27,2],[-1,26,2],[-1,25,2],[-1,24,2],[-1,23,2],[-1,22,2],[-1,21,2],[-1,20,2],[-1,19,2],[-1,18,2],[-1,17,2],[-1,16,2],[-1,15,2],[-1,14,2],[-1,13,2],[-1,12,2],[-1,11,2],[-1,10,2],[-1,9,2],[-1,8,2],[-1,7,2],[-1,6,2],[-1,5,2],[-1,4,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0]]@END_MENU_TOKEN@*/
        
        let dragonGateMap = app/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"Dragon Gate").element/*[[".otherElements[\"MapView\"]",".maps.containing(.other, identifier:\"Monarch\").element",".maps.containing(.other, identifier:\"Burlington Coat Factory\").element",".maps.containing(.other, identifier:\"Zero Zero\").element",".maps.containing(.other, identifier:\"Blue Bottle Cafe\").element",".maps.containing(.other, identifier:\"The Warfield\").element",".maps.containing(.other, identifier:\"Children’s Creativity Museum\").element",".maps.containing(.other, identifier:\"The Moscone Center\").element",".maps.containing(.other, identifier:\"The Melt\").element",".maps.containing(.other, identifier:\"Nordstrom Rack\").element",".maps.containing(.other, identifier:\"Westfield San Francisco Centre\").element",".maps.containing(.other, identifier:\"Metreon\").element",".maps.containing(.other, identifier:\"Market & Powell\").element",".maps.containing(.other, identifier:\"Parc 55 San Francisco - A Hilton Hotel\").element",".maps.containing(.other, identifier:\"San Francisco Marriott Marquis\").element",".maps.containing(.other, identifier:\"Powell St\").element",".maps.containing(.other, identifier:\"Yerba Buena Center for the Arts\").element",".maps.containing(.other, identifier:\"Hotel Nikko San Francisco\").element",".maps.containing(.other, identifier:\"Contemporary Jewish Museum\").element",".maps.containing(.other, identifier:\"The St. Regis San Francisco\").element",".maps.containing(.other, identifier:\"Hotel Spero\").element",".maps.containing(.other, identifier:\"Fashion Institute of Design & Merchandising - San Francisco Campus\").element",".maps.containing(.other, identifier:\"The Marker San Francisco\").element",".maps.containing(.other, identifier:\"Curran\").element",".maps.containing(.other, identifier:\"Museum of Ice Cream\").element",".maps.containing(.other, identifier:\"Novela\").element",".maps.containing(.other, identifier:\"Neiman Marcus\").element",".maps.containing(.other, identifier:\"Palace Hotel\").element",".maps.containing(.other, identifier:\"JW Marriott Hotel\").element",".maps.containing(.other, identifier:\"Saks Fifth Avenue\").element",".maps.containing(.other, identifier:\"Montgomery St\").element",".maps.containing(.other, identifier:\"Zara\").element",".maps.containing(.other, identifier:\"7-Eleven\").element",".maps.containing(.other, identifier:\"Galleria Park Hotel\").element",".maps.containing(.other, identifier:\"White House Garage\").element",".maps.containing(.other, identifier:\"Tacorea\").element",".maps.containing(.other, identifier:\"Sutter Stockton Garage\").element",".maps.containing(.other, identifier:\"US Post Office\").element",".maps.containing(.other, identifier:\"Pagan Idol\").element",".maps.containing(.other, identifier:\"Dragon Gate\").element"],[[[-1,39],[-1,38],[-1,37],[-1,36],[-1,35],[-1,34],[-1,33],[-1,32],[-1,31],[-1,30],[-1,29],[-1,28],[-1,27],[-1,26],[-1,25],[-1,24],[-1,23],[-1,22],[-1,21],[-1,20],[-1,19],[-1,18],[-1,17],[-1,16],[-1,15],[-1,14],[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,39],[-1,38],[-1,37],[-1,36],[-1,35],[-1,34],[-1,33],[-1,32],[-1,31],[-1,30],[-1,29],[-1,28],[-1,27],[-1,26],[-1,25],[-1,24],[-1,23],[-1,22],[-1,21],[-1,20],[-1,19],[-1,18],[-1,17],[-1,16],[-1,15],[-1,14],[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        dragonGateMap/*@START_MENU_TOKEN@*/.press(forDuration: 1.5);/*[[".tap()",".press(forDuration: 1.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dragonGateMap/*@START_MENU_TOKEN@*/.press(forDuration: 2.9);/*[[".tap()",".press(forDuration: 2.9);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dragonGateMap/*@START_MENU_TOKEN@*/.press(forDuration: 2.6);/*[[".tap()",".press(forDuration: 2.6);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dragonGateMap/*@START_MENU_TOKEN@*/.press(forDuration: 2.7);/*[[".tap()",".press(forDuration: 2.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"Dragon Gate").element.press(forDuration: 3.6);/*[[".otherElements[\"MapView\"]",".maps.containing(.other, identifier:\"Monarch\").element",".tap()",".press(forDuration: 3.6);",".maps.containing(.other, identifier:\"Burlington Coat Factory\").element",".maps.containing(.other, identifier:\"Zero Zero\").element",".maps.containing(.other, identifier:\"Blue Bottle Cafe\").element",".maps.containing(.other, identifier:\"The Warfield\").element",".maps.containing(.other, identifier:\"Children’s Creativity Museum\").element",".maps.containing(.other, identifier:\"The Moscone Center\").element",".maps.containing(.other, identifier:\"The Melt\").element",".maps.containing(.other, identifier:\"Nordstrom Rack\").element",".maps.containing(.other, identifier:\"Westfield San Francisco Centre\").element",".maps.containing(.other, identifier:\"Metreon\").element",".maps.containing(.other, identifier:\"Market & Powell\").element",".maps.containing(.other, identifier:\"Parc 55 San Francisco - A Hilton Hotel\").element",".maps.containing(.other, identifier:\"Kin Khao\").element",".maps.containing(.other, identifier:\"San Francisco Marriott Marquis\").element",".maps.containing(.other, identifier:\"Powell St\").element",".maps.containing(.other, identifier:\"Yerba Buena Center for the Arts\").element",".maps.containing(.other, identifier:\"Contemporary Jewish Museum\").element",".maps.containing(.other, identifier:\"The St. Regis San Francisco\").element",".maps.containing(.other, identifier:\"Hotel Spero\").element",".maps.containing(.other, identifier:\"Fashion Institute of Design & Merchandising - San Francisco Campus\").element",".maps.containing(.other, identifier:\"The Marker San Francisco\").element",".maps.containing(.other, identifier:\"Curran\").element",".maps.containing(.other, identifier:\"Museum of Ice Cream\").element",".maps.containing(.other, identifier:\"Novela\").element",".maps.containing(.other, identifier:\"Neiman Marcus\").element",".maps.containing(.other, identifier:\"Palace Hotel\").element",".maps.containing(.other, identifier:\"JW Marriott Hotel\").element",".maps.containing(.other, identifier:\"Saks Fifth Avenue\").element",".maps.containing(.other, identifier:\"Montgomery St\").element",".maps.containing(.other, identifier:\"Zara\").element",".maps.containing(.other, identifier:\"7-Eleven\").element",".maps.containing(.other, identifier:\"Galleria Park Hotel\").element",".maps.containing(.other, identifier:\"White House Garage\").element",".maps.containing(.other, identifier:\"Tacorea\").element",".maps.containing(.other, identifier:\"Sutter Stockton Garage\").element",".maps.containing(.other, identifier:\"US Post Office\").element",".maps.containing(.other, identifier:\"Pagan Idol\").element",".maps.containing(.other, identifier:\"Dragon Gate\").element"],[[[-1,41,2],[-1,40,2],[-1,39,2],[-1,38,2],[-1,37,2],[-1,36,2],[-1,35,2],[-1,34,2],[-1,33,2],[-1,32,2],[-1,31,2],[-1,30,2],[-1,29,2],[-1,28,2],[-1,27,2],[-1,26,2],[-1,25,2],[-1,24,2],[-1,23,2],[-1,22,2],[-1,21,2],[-1,20,2],[-1,19,2],[-1,18,2],[-1,17,2],[-1,16,2],[-1,15,2],[-1,14,2],[-1,13,2],[-1,12,2],[-1,11,2],[-1,10,2],[-1,9,2],[-1,8,2],[-1,7,2],[-1,6,2],[-1,5,2],[-1,4,2],[-1,1,2],[-1,0,1]],[[-1,41,2],[-1,40,2],[-1,39,2],[-1,38,2],[-1,37,2],[-1,36,2],[-1,35,2],[-1,34,2],[-1,33,2],[-1,32,2],[-1,31,2],[-1,30,2],[-1,29,2],[-1,28,2],[-1,27,2],[-1,26,2],[-1,25,2],[-1,24,2],[-1,23,2],[-1,22,2],[-1,21,2],[-1,20,2],[-1,19,2],[-1,18,2],[-1,17,2],[-1,16,2],[-1,15,2],[-1,14,2],[-1,13,2],[-1,12,2],[-1,11,2],[-1,10,2],[-1,9,2],[-1,8,2],[-1,7,2],[-1,6,2],[-1,5,2],[-1,4,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0]]@END_MENU_TOKEN@*/
        textField = app/*@START_MENU_TOKEN@*/.textFields["   Feld Name"]/*[[".otherElements[\"MapView\"].textFields[\"   Feld Name\"]",".textFields[\"   Feld Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        textField.tap()
        textField.typeText("TestFeld")
        
        element = app.otherElements["MapView"].children(matching: .other).element(boundBy: 3)
        element.children(matching: .button).element(boundBy: 2).tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["+ Fläche"]/*[[".otherElements[\"MapView\"]",".buttons[\"+ Fläche\"].staticTexts[\"+ Fläche\"]",".staticTexts[\"+ Fläche\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.children(matching: .button).element(boundBy: 0).tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Testfeld 145626qm"].press(forDuration: 4.0);/*[[".otherElements[\"MapView\"].tables",".cells.staticTexts[\"Testfeld 145626qm\"]",".tap()",".press(forDuration: 4.0);",".staticTexts[\"Testfeld 145626qm\"]",".tables"],[[[-1,5,1],[-1,0,1]],[[-1,4,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0,0]]@END_MENU_TOKEN@*/
        app.alerts["Feld Testfeld löschen?"].buttons["löschen"].tap()
        
        
    }
    
}
