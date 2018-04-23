//
//  Transportation.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 22/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import Foundation

class Transportation {
    
    //MARK: Properties
    
    var line: String
    var stop: String
    
    //MARK: Initialization
    
    init(line: String, stop: String){
        self.line = line
        self.stop = stop
    }
}
