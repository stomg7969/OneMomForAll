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
    @IBOutlet weak var messageField: UITextField! // Must be DISABLED if not online.
    
    let db = Firestore.firestore()
    var selectedUser: User?
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Refer to FlashChat app. It's time to touch My Models with FireStore")
        print("Lecture 205")
        viewConfiguration()
        setTableViewDelegates()
        initiateChat()
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
    
    func initiateChat() {
        // Add chat to Firestore
        let chatRef = db.collection(K.FB.collectionName)
        chatRef.document(currentUser!.email).setData([
            K.FB.chatMember: [currentUser!.email, selectedUser!.email],
            K.FB.createdAt: Date().timeIntervalSince1970,
            K.FB.messages: []
        ])
        // Add chat to Realm for offline purpose, but messageField must be DISABLED.
        // Or is it a good Idea? Realm suggests not to have big data.
    }

    @IBAction func sendBtnPressed(_ sender: UIButton) {
        if let messageBody = messageField.text, let messageSender = Auth.auth().currentUser?.email {
            // db.collection(<#T##collectionPath: String##String#>) -> this stores title of the data.
            // .addDocument() stores body. Like Fetch post with Content Body.
            db.collection(K.FB.collectionName).addDocument(data: [
                K.FB.senderField: messageSender,
                K.FB.bodyField: messageBody,
//                K.FB.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("issue in saving data: \(e)")
                } else {
                    print("successs")
                    DispatchQueue.main.async {
                        self.messageField.text = ""
                    }
                }
            }
        }
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
