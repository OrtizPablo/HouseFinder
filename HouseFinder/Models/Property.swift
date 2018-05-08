//
//  Property.swift
//  HouseFinder
//
//  Created by Ibermatica on 8/5/18.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import Foundation

class Property {
    
    var house: House
    var transportation: [Transportation]
    var supermarkets: [Supermarket]
    
    init(house: House, transportation: [Transportation], supermarkets: [Supermarket]){
        self.house = house
        self.transportation = transportation
        self.supermarkets = supermarkets
    }
    
}
