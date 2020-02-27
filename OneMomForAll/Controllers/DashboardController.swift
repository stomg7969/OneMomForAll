//
//  DashboardController.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/25/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import Firebase

class DashboardController: UIViewController {

    var loggedInUser: User?
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = K.appName
        
        username.text = loggedInUser?.name
    }
    
    @IBAction func logOutBtn(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            // Pops all the view controllers on the stack except the root view controller and updates that display.
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func updateProfileBtn(_ sender: UIButton) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Nickname", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let action = UIAlertAction(title: "Update", style: .default) { (action) in
            
            self.loggedInUser!.name = textField.text!
            self.username.text = textField.text!
            self.loggedInUser!.nameUpdated = true
//            self.updateUI(textField.text!)
            
        }
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Enter new nickname"
        }
        present(alert, animated: true, completion: nil)
    }
    
//    func updateUI(_ name: String) {
//        loggedInUser!.name = name
//        loggedInUser!.nameUpdated = true
//    }

}
