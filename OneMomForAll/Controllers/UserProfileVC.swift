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
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = selectedUser?.name
    }
    
    @IBAction func initChatBtn(_ sender: UIButton) {
        dismiss(animated: true) {
            print("success! ", self.selectedUser?.name)
            print("Now, create TVC for the chat room.")
            print("In this VC, I have currentUser and targetUser. Now I need to create chat using Firebase FireStore")
//            self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
        }
    }
    
}
