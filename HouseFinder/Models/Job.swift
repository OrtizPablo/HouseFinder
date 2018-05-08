//
//  Job.swift
//  HouseFinder
//
//  Created by Ibermatica on 8/5/18.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import Foundation
import CoreLocation

class Job {
    
    //MARK: Properties
    
    var selected: Bool
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    //MARK: Initialization
    
    init(selected: Bool, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.selected = selected
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(){
        self.selected = false
        self.latitude = 0
        self.longitude = 0
    }
    
}
