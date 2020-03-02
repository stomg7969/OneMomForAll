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
    static let appName = "OMFA👩🏽"
    static let reusingCell = "Cell"
    static let registerComplete = "LoginVC"
    static let loginComplete = "LoginToDashboard"
    static let locationList = "DashToMap"
    static let chatList = "DashToChat"
    static let childForm = "SubmitChildForm"
    
    struct C {
        static let pink = "FFB5B5"
        static let green = "14363A"
    }
    
    struct FB {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
