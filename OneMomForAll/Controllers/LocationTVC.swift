//
//  LocationTVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import RealmSwift

class LocationTVC: UITableViewController {

    var userList: Results<User>?
    var currentUser: User?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNearByUsers()
        setTableViewDelegates()
    }
    
    func loadNearByUsers() {
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
        let destinationVC = segue.destination as! UserProfileVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedUser = userList?[indexPath.row]
            destinationVC.currentUser = currentUser
        }
    }
}
