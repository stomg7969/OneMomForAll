//
//  ChatRoomVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/9/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import Firebase
// When typing in chat room, I used third party pod file called, "IQKeyboardManagerSwift"
// When rendering keyboard, the entire view will shift up so the keyboard doesn't hide anything.
class ChatRoomVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    let db = Firestore.firestore()
    var selectedUser: User?
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Refer to FlashChat app. It's time to touch My Models with FireStore
        viewConfiguration()
        setTableViewDelegates()
    }
    
    func setTableViewDelegates() {
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(UINib(nibName: K.messageCell, bundle: nil), forCellReuseIdentifier: K.reusingCell)
    }
    
    func viewConfiguration() {
        title = K.appNameInitial
        messageField.layer.cornerRadius = 20.0
//        messageField.layer.cornerRadius = messageField.frame.size.height / 5.0
        messageField.layer.borderWidth = 2.0
        messageField.layer.borderColor = UIColor.white.cgColor
        messageField.clipsToBounds = true
    }

    @IBAction func sendBtnPressed(_ sender: UIButton) {
        // ...
    }    
}

//MARK: - ChatRoom TableView
//extension ChatRoomVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // ...
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // ...
//    }
//}
