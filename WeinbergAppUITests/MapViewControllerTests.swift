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
    
}
