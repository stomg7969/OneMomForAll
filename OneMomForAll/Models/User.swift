//
//  User.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/26/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var name: String = "TemporaryName"
    @objc dynamic var nameUpdated: Bool = false
//    @objc dynamic var numOfMale: Int = 0
//    @objc dynamic var numOfFemale: Int = 0
//    @objc dynamic var childInfo: String {
//        let m: Int = self.numOfMale
//        let f: Int = self.numOfFemale
//        return "Child(ren): \(m)M \(f)F"
//    }
    
    let children = List<Child>()
    let chats = List<Chat>()
}
// Parsing int from age: String to calculate children age.
//if let number = Int(array[1].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
//    // Do something with this number
//    print(number)
//}
