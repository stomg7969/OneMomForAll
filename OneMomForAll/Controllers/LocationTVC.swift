//
//  LocationTVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class LocationTVC: UITableViewController {

    var userList: Results<User>?
    var currentUser: User?
    let realm = try! Realm()
    let db = Firestore.firestore()
    var locality: String?
//    var userArray = [User (but User without the Realm)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNearByUsers()
        setTableViewDelegates()
    }
    
    func loadNearByUsers() {
        
        
        // Fetch multiple documents with locality name brought from DashBoardVC.
        // Get locality from firestore
        if let locality = locality {
            db.collection(K.Firebase.userCollection).whereField(K.Firebase.locality, isEqualTo: locality)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting user documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print(document.data())
//                            userArray.append(// newly fetched data)
                            
                            // refer to ChatRoomVC's loadMessages()
                            // Create global array for users
                        }
                    }
            }
        }
        
        // Once Firebase works, Below codes are not necessary.
        if let currUserEmail = currentUser?.email {
            userList = realm.objects(User.self).filter("email != %@", currUserEmail)
        }
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    //MARK: - Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusingCell, for: indexPath)
        
        if let user = userList?[indexPath.row] {
            cell.textLabel?.text = "\(user.name) (with child info)"
        } else {
            cell.textLabel?.text = "No one near by."
        }
        
        return cell
    }
    
    //MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.userProfile, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.userProfile {
            let destinationVC = segue.destination as! UserProfileVC
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedUser = userList?[indexPath.row]
                destinationVC.currentUser = currentUser
            }
        }
        
    }
}
