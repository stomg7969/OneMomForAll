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
import SwiftHEXColors
import SwipeCellKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!
    
    var currUser: User? {
        didSet {
            loadChildList()
        }
    }
    var childList: Results<Child>?
    let realm = try! Realm() // Valid way of declaring for realm.
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUser()
        setTableView()
        viewConfiguration()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView?.reloadData()
    }
    
    func loadUser() {
        if let currUserEmail = Auth.auth().currentUser?.email {
            currUser = realm.objects(User.self).filter("email CONTAINS[cd] %@", currUserEmail).first
        }
    }
    
    func viewConfiguration() {
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 80
        
        navigationItem.hidesBackButton = true
        title = K.appNameInitial
        username.text = currUser?.name
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
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
                // Realm
                try self.realm.write {
                    self.currUser?.name = textField.text!
                    self.username.text = textField.text!
                    self.currUser?.nameUpdated = true
                }
                // Firestore
                self.db.collection(K.Firebase.userCollection).document(self.currUser!.email)
                .updateData([
                    K.Firebase.username: textField.text!,
                    K.Firebase.usernameUpdated: true
                ]) { (err) in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
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
    func loadChildList() {
        childList = currUser?.children.sorted(byKeyPath: "calcAge", ascending: true)
//        tableView?.reloadData()
    }
    //MARK: - Navigation Btns
    @IBAction func newChildBtn(_ sender: UIButton) {
        performSegue(withIdentifier: K.childForm, sender: self)
    }
    @IBAction func locationViewBtn(_ sender: UIButton) {
        performSegue(withIdentifier: K.locationList, sender: self)
    }    
    @IBAction func chatViewBtn(_ sender: UIButton) {
        performSegue(withIdentifier: K.chatList, sender: self)
    }
    
    
    //MARK: - Children tableView
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusingCell, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        // Cell coloring
        cellDesignConfiguration(cell)
        
        if let child = childList?[indexPath.row] {
            cell.textLabel?.text = "\(child.nickName): \(child.gender)(\(child.age))"
            
        } else {
            cell.textLabel?.text = "Add your child(ren) information"
        }
        
        return cell
    }
    
    func cellDesignConfiguration(_ cell: UITableViewCell) {
        cell.layer.borderColor = UIColor(hexString: K.C.green)?.cgColor
        cell.layer.borderWidth = 10.0
        cell.backgroundColor = UIColor(hexString: K.C.pink)
        cell.textLabel?.textColor = UIColor(hexString: K.C.green)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: K.childForm, sender: self)
    }
    //MARK: - Segue Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.childForm {
            let destinationVC = segue.destination as! ChildFormVC
            // Send over logged in user's email to filter out other than current user.
            destinationVC.currentUser = currUser
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.currentChild = childList?[indexPath.row]
            }
            
        } else if segue.identifier == K.locationList {
            let destinationVC = segue.destination as! LocationTVC
            destinationVC.currentUser = currUser                 
        }
    }
}
//MARK: - Child SwipeCellKit
// Can't separate this to SwipeTVC because this Controller is not a TVC.
extension DashboardVC: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)
        }
        // customize the action appearance
        if #available(iOS 13.0, *) {
            deleteAction.image = UIImage(systemName: "trash.fill")
        } else {
            deleteAction.image = UIImage(named: "Trash Icon")
        }
        
        return [deleteAction]
    }    
    // This method is for expansion style. e.g. swipe further to delete.
    //     https://github.com/SwipeCellKit/SwipeCellKit
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    // Lecture 287 - deleting process for dynamic purpose.
    func updateModel(at indexPath: IndexPath) {
        print("Deleting Child: \(childList?[indexPath.row].nickName ?? "nothing")")
        if let deletingChild = childList?[indexPath.row] {
            do {
                try realm.write {
                    // Lecture 286 - <#D#> in CRUD - challenge
                    realm.delete(deletingChild)
                }
            } catch {
                print("Error deleting selected item, \(error)")
            }
            // tableView.reloadData()
        }
    }
}
