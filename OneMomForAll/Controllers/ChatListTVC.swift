//
//  ChatListTVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class ChatListTVC: UITableViewController {

    let realm = try! Realm()
    let db = Firestore.firestore()
    var targetUser: String?
    var currentUser: String?
    var docName: String?
    var chats: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        setTableView()
        loadChats()
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.chatListCell, bundle: nil), forCellReuseIdentifier: K.reusingCell)
    }
    
    func loadChats() {
        if let currUserEmail = Auth.auth().currentUser?.email {
            
            db.collection(K.Firebase.collectionName).whereField(K.Firebase.chatMember, arrayContains: currUserEmail)
                .getDocuments() { (querySnapshot, err) in
                    self.chats = []
                    
                    if let err = err {
                        print("Error getting chats: \(err)")
                        
                    } else {
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            
                            if let chatMember = data[K.Firebase.chatMember] as? [Any], let messages = data[K.Firebase.messages] as? [Any], let time = data[K.Firebase.createdAt] as? TimeInterval {
                                
                                let chatterName = chatMember.first as? String == currUserEmail ? chatMember.last as? String : chatMember.first as? String
                                
                                guard let lastMsgObj = messages.last as? [String: Any] else {
                                    print("Error guarding lastMsgObj: \(err!)")
                                    return
                                }
                                
                                guard let chatPreview = lastMsgObj[K.Firebase.bodyField] as? String else {
                                    print("Error guarding chatPreview: \(err!)")
                                    return
                                }
                                
                                guard let lastMsgTime = lastMsgObj[K.Firebase.createdAt] as? TimeInterval else {
                                    print("Error guarding lastMsgTime: \(err!)")
                                    return
                                }
                                // preparing for the segue
                                self.currentUser = currUserEmail
                                self.targetUser = chatterName!
                                self.docName = [currUserEmail, chatterName!].sorted().joined()
                                // Saving fetched information as an object.
                                let loadedChat = Chat(chatterName: chatterName!, chatPreview: chatPreview, lastMsgTime: lastMsgTime, createdAt: time)
                                self.chats.append(loadedChat)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    
                                    // Each time there is a new message, scroll to the bottom.
                                    // First we need indexPath because .scrollToRow needs it.
                                    // section is 0 because we only have one section. Only chat func.
                                    let indexPath = IndexPath(row: self.chats.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
            }
        }        
    }
    //MARK: - Btn Pressed
    @IBAction func toDashBoardBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.listToDash, sender: self)
    }
    
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusingCell, for: indexPath) as! ChatListCell
        
//        cell.chatterImage.image = "not yet"
        cell.chatterName.text = chat.chatterName
        cell.chatPreview.text = chat.chatPreview
        cell.time.text = "Yesterday"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.ListToChatRoom, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.ListToChatRoom {
            let destinationVC = segue.destination as! ChatRoomVC
            
            if let targetUser = targetUser, let currentUser = currentUser {
                destinationVC.selectedUser = realm.objects(User.self).filter("email CONTAINS[cd] %@", targetUser).first
                destinationVC.currentUser = realm.objects(User.self).filter("email CONTAINS[cd] %@", currentUser).first
            }
            destinationVC.docName = docName
        }
    }
}
