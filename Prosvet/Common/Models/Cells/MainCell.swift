//
//  MainCell.swift
//  TableViewDetail
//
//  Created by adeveloper on 20.04.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var uiTitle: UILabel!
    @IBOutlet weak var uiArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
