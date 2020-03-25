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
    static let appName = "iParent👼"
    static let appNameInitial = "iParent"
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
    static let roomToList = "RoomToList"
    static let roomToDash = "RoomToDash"
    static let listToDash = "ListToDash"
        
    struct C {
        static let pink = "FFB5B5"
        static let green = "14363A"
        static let white = "FFFFFF"
    }
    
    struct Firebase {
        // collection name
        static let collectionName = "chat"
        static let userCollection = "user"
        // user info
        static let email = "email"
        static let username = "username"
        static let usernameUpdated = "usernameUpdated"
        static let numOfMale = "numOfMale"
        static let numOfFemale = "numOfFemale"
        static let locality = "locality"
        // message info
        static let senderField = "sender"
        static let bodyField = "body"
        static let createdAt = "createdAt"
        // chat info
        static let chatMember = "chatMember"
        static let messages = "messages"
        static let senderName = "senderName"
    }
}
