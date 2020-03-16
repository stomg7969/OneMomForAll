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
    var docName: String?
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfiguration()
        setTableView()
        loadMessages() // --> should initiateMessages(), I should alrdy be in chatroom.
    }
    
    func setTableView() {
        tableView.separatorStyle = .none
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.messageCell, bundle: nil), forCellReuseIdentifier: K.reusingCell)
    }
    
    func viewConfiguration() {
        navigationItem.hidesBackButton = true
        title = K.appNameInitial
//        tableView.rowHeight = 80
//        messageField.layer.cornerRadius = messageField.frame.size.height / 5.0
//        messageField.layer.cornerRadius = 20.0
//        messageField.layer.borderWidth = 2.0
//        messageField.layer.borderColor = UIColor.white.cgColor
//        messageField.clipsToBounds = true
    }
    
    func loadMessages() {
        // .getDocuments will get docs but .addSnapshotListener will listen to changes.
        // order???
        db.collection(K.Firebase.collectionName).document(docName!).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            
            if let e = error {
                print("issue loading: \(e)")
                
            } else {
                guard let document = querySnapshot else {
                  print("Error fetching document: \(error!)")
                  return
                }
                guard let data = document.data() else {
                  print("Document data was empty.")
                  return
                }
                
                for content in data[K.Firebase.messages] as! [Any] {
                    let msgContent = content as! [String: Any]
                    
                    if let msgSender = msgContent[K.Firebase.senderField] as? String, let msgBody = msgContent[K.Firebase.bodyField] as? String, let nickname = msgContent[K.Firebase.senderName] as? String, let createdAt = msgContent[K.Firebase.createdAt] as? TimeInterval {
                        
                        let loadedMsg = Message(sender: msgSender, body: msgBody, username: nickname, createdAt: createdAt)
                        self.messages.append(loadedMsg)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                            // Each time there is a new message, scroll to the bottom.
                            // First we need indexPath because .scrollToRow needs it.
                            // section is 0 because we only have one section. Only chat func.
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    //MARK: - Btn Pressed
    @IBAction func goBackBtnPressed(_ sender: UIBarButtonItem) {
//        self.navigationController!.popToViewController(DashboardVC(), animated: true)
//        self.navigationController?.pushViewController(DashboardVC(), animated: true)
        performSegue(withIdentifier: K.roomToList, sender: self)
//        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toDashBoardBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.roomToDash, sender: self)
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        if let messageBody = messageField.text, let messageSender = Auth.auth().currentUser?.email, let msgSenderUsername = currentUser?.name {
            // db.collection(<#T##collectionPath: String##String#>) -> this stores title of the data.
            // .addDocument() stores body. Like Fetch post with Content Body.
            db.collection(K.Firebase.collectionName).document(docName!).updateData([
                K.Firebase.messages: FieldValue.arrayUnion([[
                    K.Firebase.senderField: messageSender,
                    K.Firebase.bodyField: messageBody,
                    K.Firebase.senderName: msgSenderUsername,
                    K.Firebase.createdAt: Date().timeIntervalSince1970
                ]])
            ]) { (error) in
                if let e = error {
                    print("issue in saving data: \(e)")
                } else {
                    DispatchQueue.main.async {
                        self.messageField.text = ""
                    }
                }
            }
        }
    }
}

//MARK: - ChatRoom TableView
extension ChatRoomVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusingCell, for: indexPath) as! MessageCell
        
        cell.message.text = message.body
        cell.chatterName.text = message.username
        // If it's current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.dummyImage.isHidden = true
            cell.chatterName.isHidden = true
            cell.rTimeLabel.isHidden = true
            cell.lTimeLabel.isHidden = false
            
            cell.chatterImage.tintColor = UIColor(hexString: K.C.white)
            cell.chatBox.backgroundColor = UIColor(hexString: K.C.green)
            cell.message.textColor = UIColor(hexString: K.C.white)
            
            cell.lTimeLabel.text = "00:00AM"
            
        } else {
            cell.dummyImage.isHidden = false
            cell.chatterName.isHidden = false
            cell.rTimeLabel.isHidden = false
            cell.lTimeLabel.isHidden = true
            
            cell.chatterImage.tintColor = UIColor(hexString: K.C.green)
            cell.chatBox.backgroundColor = UIColor(hexString: K.C.pink)
            cell.message.textColor = UIColor(hexString: K.C.green)
            
            cell.rTimeLabel.text = "00:00AM"
        }
        return cell
    }
}

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
