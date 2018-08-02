//
//  LoginViewControllerTests.swift
//  WeinbergAppUITests
//
//  Created by ema on 02.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest

class LoginViewControllerTests: XCTestCase {
        
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
    

    func testLoginSuccessfull() {
        //given
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        var textField = element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        textField.tap()
        textField.typeText("Max M")
        textField = element.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
        textField.tap()
        textField.typeText("1234")
        //when
        app.buttons["Anmelden"].tap()
        
        //then
        XCTAssertTrue(app.otherElements["MapView"].exists)
    }
    
    func testLoginFailsUser() {
        
        //given
        let app = XCUIApplication()
        let element = app.otherElements["LoginView"].children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        let textField = element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        textField.tap()
        textField.typeText("Max")
        let secureTextField = element.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("1234")
        
        let passwortAnzeigenButton = app/*@START_MENU_TOKEN@*/.buttons["Passwort anzeigen"]/*[[".otherElements[\"LoginView\"].buttons[\"Passwort anzeigen\"]",".buttons[\"Passwort anzeigen\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        passwortAnzeigenButton.tap()
        passwortAnzeigenButton.tap()
        //when
        app/*@START_MENU_TOKEN@*/.buttons["Anmelden"]/*[[".otherElements[\"LoginView\"].buttons[\"Anmelden\"]",".buttons[\"Anmelden\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //then
        XCTAssertTrue(app.alerts["Benutzer unbekannt"].exists)
    }
    
    func testLoginFailsPassword() {
        //given
        let app = XCUIApplication()
        let element = app.otherElements["LoginView"].children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        let textField = element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        textField.tap()
        textField.typeText("Max M")
        let secureTextField = element.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("1235")
        
        let passwortAnzeigenButton = app/*@START_MENU_TOKEN@*/.buttons["Passwort anzeigen"]/*[[".otherElements[\"LoginView\"].buttons[\"Passwort anzeigen\"]",".buttons[\"Passwort anzeigen\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        passwortAnzeigenButton.tap()
        passwortAnzeigenButton.tap()
        //when
        app/*@START_MENU_TOKEN@*/.buttons["Anmelden"]/*[[".otherElements[\"LoginView\"].buttons[\"Anmelden\"]",".buttons[\"Anmelden\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //then
        XCTAssertTrue(!app.alerts["Benutzer unbekannt"].exists && app.otherElements["LoginView"].exists)
    }
    
    func testRegistration() {
        //given
        let app = XCUIApplication()
        //when
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Registrieren"]/*[[".otherElements[\"LoginView\"].buttons[\"Registrieren\"]",".buttons[\"Registrieren\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //then
        XCTAssertTrue(app.otherElements["ScannerView"].exists)
    }
    
}
