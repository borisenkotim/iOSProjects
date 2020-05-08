//
//  CellViewControllerTableViewCell.swift
//  App
//
//  Created by Admin on 09.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class StopCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var stopInfoLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
