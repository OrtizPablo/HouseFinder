//
//  HouseBathsTableViewCell.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 12/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class HouseBathsTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var bathsLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Actions
    
    // Action to add or substract baths
    @IBAction func addBath(_ sender: UIStepper) {
        bathsLabel.text = String(Int(stepper.value))
    }
    
}
