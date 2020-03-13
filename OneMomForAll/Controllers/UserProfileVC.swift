//
//  UserProfileVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/5/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    let db = Firestore.firestore()
    var selectedUser: User?
    var currentUser: User?
    var newDocName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = selectedUser?.name
    }
    
    @IBAction func initChatBtn(_ sender: UIButton) {
        // Add chat to Firestore
        let chatRef = db.collection(K.FB.collectionName)
        // sort two member to have consistnat document name.
        newDocName = [currentUser!.email, selectedUser!.email].sorted().joined()
        // the Document name will be the chat ID. So it's "searchable".
        chatRef.document(newDocName!).getDocument { (doc, err) in
            if !doc!.exists {
                chatRef.document(self.newDocName!).setData([
                    K.FB.chatMember: [self.currentUser!.email, self.selectedUser!.email],
                    K.FB.createdAt: Date().timeIntervalSince1970,
                    K.FB.messages: []
                ])
            }
        }
        // Refer <https://firebase.google.com/docs/firestore/query-data/queries?authuser=0>
        // <#Add chat to Realm#> for offline purpose, but messageField must be DISABLED.
        // Or is it a good Idea? Realm suggests not to have big data.
        // Do this part later.
        performSegue(withIdentifier: K.profileToChat, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.profileToChat {
            let destinationVC = segue.destination as! ChatRoomVC
            
            destinationVC.selectedUser = selectedUser
            destinationVC.currentUser = currentUser
            destinationVC.docName = newDocName
        }
    }    
}
