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
        
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!
    
    var currUserEmail: String?
    var user: Results<User>?
    var childList: Results<Child>?
    let realm = try! Realm() // Valid way of declaring for realm.

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = K.appName
        
        loadUserInfo()
        setTableViewDelegates()
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
    
    //MARK: - Data Manipulation
    func loadUserInfo() {
        // Filter all except current user.
        user = realm.objects(User.self).filter("email CONTAINS[cd] %@", currUserEmail!)
        username.text = user?.first?.name
    }    
    
    //MARK: - Children tableView
    //    func configTableView() {
//        view.addSubview(tableView)
//        setTableViewDelegates()
//        // Reusable cells
//    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DashboardController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.childListCell, for: indexPath)
//        cell.delegate = self
        
        if let child = childList?[indexPath.row] {
            cell.textLabel?.text = "\(child.nickName)(\(child.gender)): \(child.age)"
//            if let safeColor = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
//                cell.backgroundColor = safeColor
//                // Lecture 291 - ChameleonFramework - contrast
//                cell.textLabel?.textColor = ContrastColorOf(safeColor, returnFlat: true)
//            }
//
//            //Ternary operator ==>
//            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "Add your child(ren) information"
        }
        
        return cell
    }        
}
