//
//  Wine.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 6.08.21.
//
import UIKit
import Foundation

struct Wine {
    var image: String
    var name: String
    var price: Double
    var test: String {
        "\(price)"
    }
}

extension Wine {
    
    func getRealmModel() -> RealmWine {
        RealmWine(wine: self)
    }
}
