//
//  ChatListTVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit

class ChatListTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register 'this' cell with my custom nib file
        tableView.register(UINib(nibName: K.chatListCell, bundle: nil), forCellReuseIdentifier: K.reusingCell)
    }
}
