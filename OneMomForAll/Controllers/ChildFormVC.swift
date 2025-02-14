//
//  NewChildVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import RealmSwift

class ChildFormVC: UIViewController {

    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var formBtn: UIButton!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ageTxtField: UITextField!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    
    var currentUser: User?
    var currentChild: Child?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxtField.delegate = self
        ageTxtField.delegate = self

        if currentChild != nil {
            prefillForm()
        }
    }
    //MARK: - Info pre-filling
    func prefillForm() {
        pageLabel.text = "Update Profile"
        formBtn.setTitle("Update", for: .normal)
        
        nameTxtField.text = currentChild?.nickName
//         Get numbers from the age string.
        ageTxtField.text = (currentChild?.age.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
        
        if (currentChild?.age.contains("m"))! {
            monthBtn.isSelected = true
            yearBtn.isSelected = false
        } else {
            monthBtn.isSelected = false
            yearBtn.isSelected = true
        }
        
        if currentChild?.gender == "Male" {
            maleBtn.isSelected = true
            femaleBtn.isSelected = false
        } else {
            maleBtn.isSelected = false
            femaleBtn.isSelected = true
        }
    }
    
    //MARK: - Form Btns Pressed
    @IBAction func mosYrBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        monthBtn.isSelected = false
        yearBtn.isSelected = false
        sender.isSelected = true
    }
    @IBAction func genderBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        maleBtn.isSelected = false
        femaleBtn.isSelected = false
        sender.isSelected = true
    }
    @IBAction func submitFormBtn(_ sender: UIButton) {
        if nameTxtField.text!.count < 2 || ageTxtField.text!.count == 0 {
            let alert = UIAlertController(title: "All fields are Required", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        
        } else {
            // functionality of the submitBtn will do different action according to existance of 'currentChild'.
            if currentChild != nil {
                updateChild()
            } else {
                createChild()
            }
        }        
    }
    
    func createChild() {
        if let user = self.currentUser {
            do {
                try self.realm.write {
                    let newChild = Child()
                    newChild.nickName = nameTxtField.text!
                    if monthBtn.isSelected {
                        newChild.calcAge = Int(ageTxtField.text!)!
                        newChild.age = "\(ageTxtField.text!)m"
                    } else {
                        newChild.calcAge = Int(ageTxtField.text!)! * 12
                        newChild.age = "\(ageTxtField.text!)y"
                    }
//                    newChild.age = monthBtn.isSelected ? "\(ageTxtField.text!)m" : "\(ageTxtField.text!)y"
                    if maleBtn.isSelected {
                        newChild.gender = "Male"
                        user.numOfMale += 1
                    } else {
                        newChild.gender = "Female"
                        user.numOfFemale += 1
                    }
                    // newChild.gender = maleBtn.isSelected ? "Male" : "Female"
                    user.children.append(newChild)
                }
                // Update childinfo on Firestore?
            navigationController?.popViewController(animated: true)
            } catch {
                print("Error creating \(error)")
            }
        }
    }
    
    func updateChild() {
        if let user = self.currentUser, let child = self.currentChild {
            do {
                try self.realm.write {
                    child.nickName = nameTxtField.text!
                    if monthBtn.isSelected {
                        child.calcAge = Int(ageTxtField.text!)!
                        child.age = "\(ageTxtField.text!)m"
                    } else {
                        child.calcAge = Int(ageTxtField.text!)! * 12
                        child.age = "\(ageTxtField.text!)y"
                    }
//                    child.age = monthBtn.isSelected ? "\(ageTxtField.text!)m" : "\(ageTxtField.text!)y"
                    if child.gender == "Male" && maleBtn.isSelected {
                        child.gender = "Male"
                    } else if child.gender == "Male" && femaleBtn.isSelected {
                        child.gender = "Female"
                        user.numOfFemale += 1
                        user.numOfMale -= 1
                    } else if child.gender == "Female" && femaleBtn.isSelected {
                        child.gender = "Female"
                    } else if child.gender == "Female" && maleBtn.isSelected {
                        child.gender = "Male"
                        user.numOfFemale -= 1
                        user.numOfMale += 1
                    }                    
//                    child.gender = maleBtn.isSelected ? "Male" : "Female"
                }
                // Update childinfo on Firestore?
                navigationController?.popViewController(animated: true)
            } catch {
                print("Error updating \(error)")
            }
        }
    }
}
//MARK: - UITextField Delegate
extension ChildFormVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
