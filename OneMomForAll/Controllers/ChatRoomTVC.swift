//
//  ChatRoomTVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/3/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit

class ChatRoomTVC: UITableViewController {

    var selectedUser: User?
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    // Register 'this' cell with my custom nib file
       tableView.register(UINib(nibName: K.messageCell, bundle: nil), forCellReuseIdentifier: K.reusingCell)
        
        print("Segue to chatroom from profile page is successful.")
        print("Next step is to design chat room")
    }
}
