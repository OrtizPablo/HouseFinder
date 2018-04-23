//
//  SupermarketTableViewCell.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 23/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class SupermarketTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var supermarketImageView: UIImageView!
    @IBOutlet weak var supermarketLabel: UILabel!
    @IBOutlet weak var supermarketSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
