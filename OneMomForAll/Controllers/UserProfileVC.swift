//
//  UserProfileVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/5/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = selectedUser?.name
    }
    
    @IBAction func initChatBtn(_ sender: UIButton) {
        dismiss(animated: true) {
            print("success! ", self.selectedUser?.name)
            print("Now, create TVC for the chat room.")
            print("To create the chat room, I need to design Chat model with Firebase/Firestore. Look at the saved YouTube.")
//            self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
        }
    }
    
}
