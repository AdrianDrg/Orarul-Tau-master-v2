//
//  HeaderTableViewCell.swift
//  Orarul Tau
//
//  Created by Draghici Adrian on 16/04/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var dayText: UILabel!
    @IBOutlet weak var intervalOrar: UILabel!
    @IBOutlet weak var dropDownImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
