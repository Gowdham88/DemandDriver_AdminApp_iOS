//
//  DriverlistTableViewCell.swift
//  DemandDriverAdmin
//
//  Created by Gowdhaman on 13/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit

class DriverlistTableViewCell: UITableViewCell {

    @IBOutlet var driverName: UILabel!
    @IBOutlet var driverphoneNumber: UILabel!
    @IBOutlet var driverDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
