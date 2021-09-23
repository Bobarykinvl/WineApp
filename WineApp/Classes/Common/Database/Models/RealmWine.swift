//
//  RealmWine.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 12.08.21.
//

import RealmSwift

class RealmWine: Object {
    
    @objc dynamic var image = ""
    @objc dynamic var name = ""
    @objc dynamic var price: Double = 0
    
    convenience init(wine: Wine) {
        self.init()
        self.image = wine.image
        self.name = wine.name
        self.price = wine.price
    }
}

extension RealmWine {
    
    func getModel() -> Wine {
        Wine(image: self.image,name: self.name,price: self.price)
    }
}
