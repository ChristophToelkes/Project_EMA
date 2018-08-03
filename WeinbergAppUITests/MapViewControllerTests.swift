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
        let element = app.otherElements["LoginView"].children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        
        let secureTextField = element.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Anmelden"]/*[[".otherElements[\"LoginView\"].buttons[\"Anmelden\"]",".buttons[\"Anmelden\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["+ Fläche"]/*[[".otherElements[\"MapView\"]",".buttons[\"+ Fläche\"].staticTexts[\"+ Fläche\"]",".staticTexts[\"+ Fläche\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.otherElements["Brandy Melville"].press(forDuration: 0.6);/*[[".otherElements[\"MapView\"]",".maps.otherElements[\"Brandy Melville\"]",".tap()",".press(forDuration: 0.6);",".otherElements[\"Brandy Melville\"]"],[[[-1,4,2],[-1,1,2],[-1,0,1]],[[-1,4,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0]]@END_MENU_TOKEN@*/
        
        let appleUnionSquareMap = app/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"Apple Union Square").element/*[[".otherElements[\"MapView\"]",".maps.containing(.other, identifier:\"54 Mint\").element",".maps.containing(.other, identifier:\"Pickwick Hotel\").element",".maps.containing(.other, identifier:\"The Moscone Center\").element",".maps.containing(.other, identifier:\"The Melt\").element",".maps.containing(.other, identifier:\"Fifth & Mission \/ Yerba Buena Garage\").element",".maps.containing(.other, identifier:\"Hotel Zetta - San Francisco\").element",".maps.containing(.other, identifier:\"ICICLES\").element",".maps.containing(.other, identifier:\"Nordstrom Rack\").element",".maps.containing(.other, identifier:\"Westfield San Francisco Centre\").element",".maps.containing(.other, identifier:\"Nordstrom\").element",".maps.containing(.other, identifier:\"Mel's Drive-In\").element",".maps.containing(.other, identifier:\"Denny's\").element",".maps.containing(.other, identifier:\"Target\").element",".maps.containing(.other, identifier:\"Market & Powell\").element",".maps.containing(.other, identifier:\"Parc 55 San Francisco - A Hilton Hotel\").element",".maps.containing(.other, identifier:\"Sephora\").element",".maps.containing(.other, identifier:\"Hotel Zelos San Francisco\").element",".maps.containing(.other, identifier:\"San Francisco Marriott Marquis\").element",".maps.containing(.other, identifier:\"Tropisueño Mexican Kitchen\").element",".maps.containing(.other, identifier:\"Urban Outfitters\").element",".maps.containing(.other, identifier:\"GameStop\").element",".maps.containing(.other, identifier:\"Powell St\").element",".maps.containing(.other, identifier:\"Ross Dress For Less\").element",".maps.containing(.other, identifier:\"Uniqlo\").element",".maps.containing(.other, identifier:\"Standort\").element",".maps.containing(.other, identifier:\"Forever 21\").element",".maps.containing(.other, identifier:\"Contemporary Jewish Museum\").element",".maps.containing(.other, identifier:\"Ellis O'Farrell Garage\").element",".maps.containing(.other, identifier:\"H&M\").element",".maps.containing(.other, identifier:\"Four Seasons Hotel San Francisco\").element",".maps.containing(.other, identifier:\"Barneys New York\").element",".maps.containing(.other, identifier:\"Villa Florence\").element",".maps.containing(.other, identifier:\"Equinox\").element",".maps.containing(.other, identifier:\"Ben & Jerry's\").element",".maps.containing(.other, identifier:\"Macy's Men's Store\").element",".maps.containing(.other, identifier:\"Museum of Ice Cream\").element",".maps.containing(.other, identifier:\"Handlery Union Square Hotel\").element",".maps.containing(.other, identifier:\"Burger Bar\").element",".maps.containing(.other, identifier:\"Neiman Marcus\").element",".maps.containing(.other, identifier:\"Geary & Powell\").element",".maps.containing(.other, identifier:\"Chanel\").element",".maps.containing(.other, identifier:\"The Westin St. Francis\").element",".maps.containing(.other, identifier:\"Hakkasan San Francisco\").element",".maps.containing(.other, identifier:\"Union Square\").element",".maps.containing(.other, identifier:\"GOYARD Boutique\").element",".maps.containing(.other, identifier:\"Gucci\").element",".maps.containing(.other, identifier:\"Morton's The Steakhouse\").element",".maps.containing(.other, identifier:\"Apple Union Square\").element"],[[[-1,48],[-1,47],[-1,46],[-1,45],[-1,44],[-1,43],[-1,42],[-1,41],[-1,40],[-1,39],[-1,38],[-1,37],[-1,36],[-1,35],[-1,34],[-1,33],[-1,32],[-1,31],[-1,30],[-1,29],[-1,28],[-1,27],[-1,26],[-1,25],[-1,24],[-1,23],[-1,22],[-1,21],[-1,20],[-1,19],[-1,18],[-1,17],[-1,16],[-1,15],[-1,14],[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,48],[-1,47],[-1,46],[-1,45],[-1,44],[-1,43],[-1,42],[-1,41],[-1,40],[-1,39],[-1,38],[-1,37],[-1,36],[-1,35],[-1,34],[-1,33],[-1,32],[-1,31],[-1,30],[-1,29],[-1,28],[-1,27],[-1,26],[-1,25],[-1,24],[-1,23],[-1,22],[-1,21],[-1,20],[-1,19],[-1,18],[-1,17],[-1,16],[-1,15],[-1,14],[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        appleUnionSquareMap/*@START_MENU_TOKEN@*/.press(forDuration: 1.3);/*[[".tap()",".press(forDuration: 1.3);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        appleUnionSquareMap/*@START_MENU_TOKEN@*/.press(forDuration: 2.4);/*[[".tap()",".press(forDuration: 2.4);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        appleUnionSquareMap/*@START_MENU_TOKEN@*/.press(forDuration: 1.5);/*[[".tap()",".press(forDuration: 1.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                
    }
    
}
