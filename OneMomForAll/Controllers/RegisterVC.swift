//
//  TableViewController.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/25/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    let realm = try! Realm()
    var user: Results<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func regiBtnPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let pw = pwTextField.text {
            Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
                if email.count < 1 {
                    let alert = UIAlertController(title: "All fields are Required", message: "", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                }
                
                if let e = error {
                    // .localizedDescription -> gives simplifed feedback.
                    // Good method to display on user screen.
//                    print(e.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: "\(e.localizedDescription)", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                
                } else {
                    // Register success
                    
                    let newUser = User()
                    newUser.email = email
                    // Realm will automatically update changes, monitor.
                    self.saveUser(newUser)
                    
                    let alert = UIAlertController(title: "Success", message: "Welcome! You can Log In now.", preferredStyle: .alert)
//                    let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                        // Navigate back to welcome VC
                        //                    self.dismiss(animated: true, completion: nil)
                        //                    self.performSegue(withIdentifier: K.registerComplete, sender: self)
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: - Data Manipulation
    func saveUser(_ user: User) {
        do {
            // .write - committing changes.
            try realm.write {
                realm.add(user)
            }
        } catch {
            print("Error saving category \(error)")
        }
//        tableView.reloadData()
    }
}

//            var textField = UITextField()
//
//            let alert = UIAlertController(title: "All fields are Required", message: "", preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//
//            let action = UIAlertAction(title: "Add", style: .default) { (action) in
//
//                let newCategory = Category()
//                newCategory.name = textField.text!
//                // Lecture 289 - Random color. Refer to link at the top.
//                newCategory.color = RandomFlatColor().hexValue()
//                // Realm will automatically update changes, monitor.
//                self.saveCategories(category: newCategory)
//
//            }
//            alert.addAction(action)
//            alert.addAction(cancel)
//            alert.addTextField { (field) in
//                textField = field
//                textField.placeholder = "Add a new category"
//            }
//            present(alert, animated: true, completion: nil)
