//
//  DashboardController.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/25/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class DashboardController: UIViewController {

    var currUserEmail: String?
    var user: Results<User>?
    let realm = try! Realm() // Valid way of declaring for realm.
    
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = K.appName
        
        loadUserInfo()
    }
    //MARK: - Log out
    @IBAction func logOutBtn(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            // Pops all the view controllers on the stack except the root view controller and updates that display.
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    //MARK: - Update User Nickname
    @IBAction func updateProfileBtn(_ sender: UIButton) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Nickname", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let action = UIAlertAction(title: "Update", style: .default) { (action) in
            
            do {
                try self.realm.write {
                    self.user?.first?.name = textField.text!
                    self.username.text = textField.text!
                    self.user?.first?.nameUpdated = true
                }
            } catch {
                print("Error updating user's nickname, \(error)")
            }
        }
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Enter new nickname"
        }
        present(alert, animated: true, completion: nil)
    }
    //MARK: - User Children List
    // asdfasdf
    // asdfasdf
    
    
    //MARK: - Data Manipulation
    func loadUserInfo() {
        // Filter all except current user.
        user = realm.objects(User.self).filter("email CONTAINS[cd] %@", currUserEmail!)
        username.text = user?.first?.name
    }
}
