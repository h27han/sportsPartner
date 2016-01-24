//
//  dynamicCell.swift
//  sportsPartner
//
//  Created by Laetitia Huang on 2016-01-24.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit

class dynamicCell: UITableViewCell {

    @IBOutlet weak var row1: UILabel!
    
    @IBOutlet weak var row2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
