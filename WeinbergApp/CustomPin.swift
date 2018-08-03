//
//  CustomPin.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 11.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import UIKit
import MapKit



class CustomPin: NSObject, MKAnnotation {
    let title: String?
  
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
}
