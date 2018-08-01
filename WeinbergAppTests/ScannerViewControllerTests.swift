//
//  ScannerViewControllerTests.swift
//  WeinbergAppTests
//
//  Created by ema on 01.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest
import AVFoundation
@testable import WeinbergApp

class ScannerViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testScannerViewController() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ScannerViewControllerID") as! ScannerViewController
        //when
        _ = sut.view
        //then
        XCTAssertNotNil(sut.captureSession)
    }
    
    func testFailed() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ScannerViewControllerID") as! ScannerViewController
        //when
        _ = sut.failed()
        //then
        XCTAssertNil(sut.captureSession)
    }
    
    func testViewWillAppear() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ScannerViewControllerID") as! ScannerViewController
        _ = sut.view
        //when
        _ = sut.viewWillAppear(false)
        //then
        XCTAssert(sut.captureSession.isRunning)
    }
    
    func testViewWillDisappear() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ScannerViewControllerID") as! ScannerViewController
        _ = sut.view
        //when
        _ = sut.viewWillDisappear(false)
        //then
        XCTAssert(!sut.captureSession.isRunning)
    }
    
    /*func testMetadataOutput() {
        //given
        let sut = MockScannerViewController()
        _ = sut.viewDidLoad()
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        let avCaptureConnection = AVCaptureConnection()
        //when
        _ = sut.metadataOutput(avCaptureMetadataOutput, didOutput: [], from: avCaptureConnection)
        //then
        XCTAssert(!sut.captureSession.isRunning)
    }*/
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
