//
//  AddCaptureViewControllerTests.swift
//  WeinbergAppTests
//
//  Created by ema on 01.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest
@testable import WeinbergApp

class AddCaptureViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddCaptureViewController() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "AddCaptureViewControllerID") as! AddCaptureViewController
        //when
        _ = sut.view
        //then
        XCTAssert(sut.tableView.numberOfSections == 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
