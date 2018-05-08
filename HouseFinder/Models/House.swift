//
//  House.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 06/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit
import CoreLocation

class House {
    
    //MARK: Properties
    
    var name: String
    var roomsNumber: Int
    var bathsNumber: Int
    var rating: Int
    var selected: Bool
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    //MARK: Initialization
    
    init(name: String, roomsNumber: Int, bathsNumber: Int, rating: Int, selected: Bool, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        self.name = name
        self.roomsNumber = roomsNumber
        self.bathsNumber = bathsNumber
        self.rating = rating
        self.selected = selected
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(){
        self.name = ""
        self.roomsNumber = 1
        self.bathsNumber = 1
        self.rating = 5
        self.selected = false
        self.latitude = 0
        self.longitude = 0
    }
    
}
