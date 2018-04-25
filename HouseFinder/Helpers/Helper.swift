//
//  Helper.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 11/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class Helper {

    // Function that returns all the supermarkets checked
    func getSupermarketsChecked(supermarkets: [Supermarket]) -> [Supermarket]{
        var array:[Supermarket] = []
        for supermarket in supermarkets {
            if supermarket.check {
                array.append(supermarket)
            }
        }
        return array
    }
    
}
