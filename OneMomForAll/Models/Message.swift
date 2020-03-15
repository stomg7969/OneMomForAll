//
//  Message.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/27/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import Foundation
//import RealmSwift

struct Message {
    let sender: String
    let body: String
    let username: String
    let createdAt: TimeInterval
//    @objc dynamic var sender: String = ""
//    @objc dynamic var body: String = ""
    // add time message was created. (hh:mm AM/PM)
//     @objc dynamic var messageTime: String {
//        let myDate = Date()
//        let myDateFormatter = DateFormatter()
//        myDateFormatter.dateFormat = "h:mm a"
//        return myDateFormatter.string(from: myDate)
//    }
    
//    var parentChat = LinkingObjects(fromType: Chat.self, property: "messages")
}
