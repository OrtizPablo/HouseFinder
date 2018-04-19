//
//  TransportationTableViewCell.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 19/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class TransportationTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var tubeImage: UIImageView!
    @IBOutlet weak var tubeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
