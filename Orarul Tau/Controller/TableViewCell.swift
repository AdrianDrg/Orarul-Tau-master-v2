//
//  TableViewCell.swift
//  Orarul Tau
//
//  Created by Draghici Adrian on 16/04/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var intervalOrar: UILabel!
    @IBOutlet weak var identifier: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
