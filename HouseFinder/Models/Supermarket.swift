//
//  Supermarket.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 23/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class Supermarket {
    
    //MARK: Properties
    
    var name: String
    var check: Bool
    var image: UIImage?
    
    //MARK: Initialization
    
    init(name: String, check: Bool, image: UIImage?){
        self.name = name
        self.check = check
        self.image = image
    }
    
}
