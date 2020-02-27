//
//  Message.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object {
    @objc dynamic var sender: String = ""
    @objc dynamic var body: String = ""
    
    var parentChat = LinkingObjects(fromType: Chat.self, property: "messages")
}
