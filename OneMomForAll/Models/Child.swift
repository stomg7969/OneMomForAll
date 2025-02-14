//
//  Child.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import Foundation
import RealmSwift

class Child: Object {
    @objc dynamic var nickName: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var age: String = "10m"
    @objc dynamic var calcAge: Int = 0
//    if let num = Int(age.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
//        if age.contains("y") {
//            return num * 12
//        } else {
//            return num
//        }
//    }
//    return 0
    
//    @objc dynamic var birthdate: String {
//        // get current year/month/day in just numbers if possible.
//        // parse age to get just number.
//        // depending on m or y, calc the approximate age of this child.
//        // return it as a string.
//    }
    /*
     Declaring a primary key allows objects to be looked up and updated efficiently and enforces uniqueness for each value. Once an object with a primary key is added to a Realm, the primary key cannot be changed.
     */
//    @objc dynamic var id = 0
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    // how about just calculating the year. e.g. ask user to provide only the year children are born.
    
    var parentUser = LinkingObjects(fromType: User.self, property: "children")
}
// Parsing int from age: String to calculate children age.
//if let number = Int(array[1].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
//    // Do something with this number
//    print(number)
//}
