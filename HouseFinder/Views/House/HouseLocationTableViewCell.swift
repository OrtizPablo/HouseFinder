//
//  LocationTableViewCell.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 12/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class HouseLocationTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var checkLocation: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
