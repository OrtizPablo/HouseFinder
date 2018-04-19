//
//  Helper.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 11/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class Helper {
    
    // Function that shows an alert view 
    func showOkAlertView(_ viewController: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
}
