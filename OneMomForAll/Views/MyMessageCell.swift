//
//  MyMessageCell.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/15/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit

class MyMessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
