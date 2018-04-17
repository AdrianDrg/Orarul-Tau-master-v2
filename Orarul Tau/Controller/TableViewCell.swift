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
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var intervalOrar: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
