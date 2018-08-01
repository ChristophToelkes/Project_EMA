//
//  MockAddCaptureViewController.swift
//  WeinbergAppTests
//
//  Created by ema on 01.08.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
@testable import WeinbergApp

class MockAddCaptureViewController: AddCaptureViewController {
    
    var loadEntriesCounter: Int = 0
    
    override func loadEntries() {
        loadEntriesCounter += 1
    }
}
