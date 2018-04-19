//
//  HousePunctuationTableViewCell.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 12/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class HouseRatingTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: Actions
    
    // Action that gives the rating of the house by moving the slider
    @IBAction func rateHouse(_ sender: UISlider) {
        ratingLabel.text = String(Int(ratingSlider.value))
    }
}
