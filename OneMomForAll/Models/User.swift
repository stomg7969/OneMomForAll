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
    let children = List<Child>()
    let chats = List<Chat>()
}
