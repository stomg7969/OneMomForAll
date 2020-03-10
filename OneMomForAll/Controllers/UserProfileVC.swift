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
        performSegue(withIdentifier: K.profileToChat, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.profileToChat {
            let destinationVC = segue.destination as! ChatRoomVC
            
            destinationVC.selectedUser = selectedUser
            destinationVC.currentUser = currentUser
        }
    }    
}
