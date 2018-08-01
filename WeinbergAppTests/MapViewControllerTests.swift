//
//  MapViewControllerTests.swift
//  WeinbergAppTests
//
//  Created by ema on 01.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import XCTest
import MapKit
@testable import WeinbergApp

class MapViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMapViewController() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "MapViewControllerID") as! MapViewController
        //when
        _ = sut.view
        //then
        XCTAssert(sut.tableViewAreas.numberOfSections == 1)
    }
    
    func testMapView1() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "MapViewControllerID") as! MapViewController
        //when
        let renderer = sut.mapView(MKMapView(), rendererFor: MKPolyline())
        //then
        XCTAssertNotNil(renderer)
    }
    
    func testMapView2() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "MapViewControllerID") as! MapViewController
        //when
        let renderer = sut.mapView(MKMapView(), rendererFor: MKPolygon())
        //then
        XCTAssertNotNil(renderer)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
