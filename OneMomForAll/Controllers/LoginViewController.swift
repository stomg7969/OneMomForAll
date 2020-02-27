//
//  LoginViewController.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/25/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let pw = pwField.text {
            Auth.auth().signIn(withEmail: email, password: pw) { authResult, error in
                if let e = error {
                    // log in failed alert
                    let alert = UIAlertController(title: "Error", message: "\(e.localizedDescription)", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // If login is successful, go to main menu.
                    self.performSegue(withIdentifier: K.loginComplete, sender: self)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DashboardController
        // Send over logged in user's email to filter out other than current user.
        destinationVC.currUserEmail = emailField.text!
    }
}
