//
//  MessageCell.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
// Lecture 203.
class MessageCell: UITableViewCell {

    @IBOutlet weak var chatBox: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var chatterName: UILabel!
    @IBOutlet weak var chatterImage: UIImageView!
    @IBOutlet weak var dummyImage: UIImageView!
    @IBOutlet weak var lTimeLabel: UILabel!
    @IBOutlet weak var rTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        chatBox.layer.cornerRadius = chatBox.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
