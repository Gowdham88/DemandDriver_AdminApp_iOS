//
//  distanceTableViewCell.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 10/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit

class distanceTableViewCell: UITableViewCell {

    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var distancelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
