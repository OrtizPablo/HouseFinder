//
//  Extension+UIViewController.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 20/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Function that shows an alert view
    func showOkAlertView(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
