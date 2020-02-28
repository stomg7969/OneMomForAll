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
    static let appName = "One MOM👩🏽For ALL"
    static let reusingCell = "Cell"
    static let registerComplete = "LoginVC"
    static let loginComplete = "LoginToDashboard"
    static let profile = "DashToProfile"
    static let parentsList = "DashToMap"
    static let chatList = "DashToChat"
    static let addNewChild = "AddNewChild"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
