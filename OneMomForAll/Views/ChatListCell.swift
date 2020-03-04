//
//  ChatListCell.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/3/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {
    
    @IBOutlet weak var chatterImage: UIImageView!
    @IBOutlet weak var chatterName: UILabel!
    @IBOutlet weak var chatPreview: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
