//
//  Constants.swift
//  OneMomForAll
//
//  Created by K1 Park on 2/25/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

struct K {
    // static turns its property to 'type' property.
    // without static, the property is 'instance' property.
    
    // with static, I don't have to initialize to call it.
    // without static -> I need: let contants = Constants()
    // with static -> I can: Constants.registerSegue
    
    // Naming
    static let appName = "One Mom👩🏽For All"
    static let appNameInitial = "OMFA👩🏽"
    // Cell names
    static let reusingCell = "Cell"
    static let messageCell = "MessageCell"
    static let chatListCell = "ChatListCell"
    // Segue Identifiers
    static let registerComplete = "LoginVC"
    static let loginComplete = "LoginToDashboard"
    static let locationList = "DashToMap"
    static let chatList = "DashToChatList"
    static let childForm = "SubmitChildForm"
    static let userProfile = "MapToUserProfile"
    static let ListToChatRoom = "ChatListToChat"
    static let profileToChat = "ProfileToChat"
    static let roomToChatList = "ChatRoomToChatList"
        
    struct C {
        static let pink = "FFB5B5"
        static let green = "14363A"
        static let white = "FFFFFF"
    }
    
    struct Firebase {
        static let collectionName = "chat"
        static let senderField = "sender"
        static let bodyField = "body"
        static let createdAt = "createdAt"
        static let chatMember = "chatMember"
        static let messages = "messages"
        static let senderName = "senderName"
    }
}
