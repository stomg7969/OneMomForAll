//
//  Chat.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import Foundation
import RealmSwift

class Chat: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var preview: String {
        return messages.last?.body ?? ""
    }
    // Also add Date(yyyy/mm/dd) for section
    // add time / yesterday / weekname / mm dd for preview.
    
    let messages = List<Message>()
    var parentUser = LinkingObjects(fromType: User.self, property: "chats")
}
