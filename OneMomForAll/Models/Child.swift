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
    
    var parentUser = LinkingObjects(fromType: User.self, property: "children")
}
