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
    let db = Firestore.firestore()
    var user: Results<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func regiBtnPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let pw = pwTextField.text {
            if email.count < 1 {
                let alert = UIAlertController(title: "All fields are Required", message: "", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
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
                        let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                            // Navigate back to welcome VC
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        alert.addAction(cancel)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    //MARK: - Data Manipulation
    func saveUser(_ user: User) {
        do {
            // .write - committing changes (Realm).
            try realm.write {
                realm.add(user)
            }
            // Firestore
            db.collection(K.Firebase.userCollection).document(user.email).setData([
                K.Firebase.email: user.email,
                K.Firebase.username: "TemporaryName",
                K.Firebase.usernameUpdated: false,
                K.Firebase.numOfMale: 0,
                K.Firebase.numOfFemale: 0,
                K.Firebase.locality: ""
            ]) { err in
                if let err = err {
                    print("Error writing user doc while registering: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        } catch {
            print("Error saving category \(error)")
        }
//        tableView.reloadData()
    }
}
