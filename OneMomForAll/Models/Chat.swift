//
//  Chat.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import Foundation
//import RealmSwift

struct Chat {
    let chatterEmail: String?
    var chatterName: String?
    let chatPreview: String?
    let lastMsgTime: TimeInterval?
    let createdAt: TimeInterval?
    
    init(chatterEmail: String, chatterName: String, chatPreview: String, lastMsgTime: TimeInterval, createdAt: TimeInterval) {
        self.chatterEmail = chatterEmail
        self.chatterName = chatterName
        self.chatPreview = chatPreview
        self.lastMsgTime = lastMsgTime
        self.createdAt = createdAt
    }
//    @objc dynamic var owner: String = ""
//    @objc dynamic var target: String = ""
//    @objc dynamic var preview: String {
//        return messages.last?.body ?? ""
//    } --> This kind of format doesn't work with Realm.
    // Also add Date(yyyy/mm/dd) for section
    // add time / yesterday / weekname / mm dd for preview.
//    @objc dynamic var messageTime: String {
//        let lastMsgTime = messages.last?.messageTime
//        return
//    }
    
//    let messages = List<Message>()
//    var parentUser = LinkingObjects(fromType: User.self, property: "chats")
}
