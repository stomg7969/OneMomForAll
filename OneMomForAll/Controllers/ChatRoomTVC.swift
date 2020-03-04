//
//  ChatRoomTVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/3/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit

class ChatRoomTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    // Register 'this' cell with my custom nib file
       tableView.register(UINib(nibName: K.messageCell, bundle: nil), forCellReuseIdentifier: K.reusingCell)
    }
}
