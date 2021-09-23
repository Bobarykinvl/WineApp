//
//  RealmUser.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 6.08.21.
//

import RealmSwift

class RealmUser: Object {
    
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    
    convenience init(user: User){
        self.init()
        self.email = user.email
        self.password = user.password
    }
}






