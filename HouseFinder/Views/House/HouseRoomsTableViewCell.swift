//
//  HouseRoomsNumberTableViewCell.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 12/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class HouseRoomsTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var roomsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: Actions
    
    // Action to add or substract rooms
    @IBAction func addRoom(_ sender: UIStepper) {
        roomsLabel.text = String(Int(stepper.value))
    }
}
