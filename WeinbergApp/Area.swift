//
//  Area.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 10.07.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//

import Foundation
import MapKit


class Area {

    var name: String?
    var points = [CLLocationCoordinate2D]()
     

    init(name: String, points: [CLLocationCoordinate2D]){
        self.name = name
        self.points = points
    }
}
