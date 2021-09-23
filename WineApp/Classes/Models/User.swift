//
//  User.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 9.08.21.
//

import Foundation

struct User {
    var email: String
    var password: String
}

extension User {
    
    func getRealmModel() -> RealmUser {
        RealmUser(user: self)
    }
}
