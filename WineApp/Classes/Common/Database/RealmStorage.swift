//
//  RealmLogic.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 6.08.21.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

class RealmStorage {

    private let realm = try? Realm()
    private var notificationToken: NotificationToken?
    private let bag = DisposeBag()
    
    
    // MARK: Work with user
    func saveUser(object: RealmUser) {
        try? realm?.write {
            realm?.add(object)
        }
    }
    
    func getUser(by email: String) -> RealmUser? {
        realm?.objects(RealmUser.self).filter("email == '\(email)'").first
    }
    
    func checkUserToLogin(by email: String, password: String) -> RealmUser? {
        let userByEmail = realm?.objects(RealmUser.self).filter("email == '\(email)' && password == '\(password)'").first
        return userByEmail
    }
//    func get<T: Object>(type: T.Type) -> [T] {
//        realm!.objects(type)
//    }
    
    // MARK: Work with wine
    func saveWine(object: Wine) {
        try? realm?.write {
            realm?.add(RealmWine(wine: object))
        }
    }
    
//    func saveWine(object: Wine) {
//        try? realm?.write {
//            realm?.add(RealmWine(wine: object))
//        }
//    }
    
    func getListOfWine() -> Driver<[Wine]> {
        let listOfWine = self.realm?.objects(RealmWine.self)
        return Observable.array(from: listOfWine!).asDriver(onErrorJustReturn: Array()).map {
            $0.map { $0.getModel() }
        }
    }
    
    func removeWine(by indexPath: IndexPath) {
        let listOfWine = self.realm?.objects(RealmWine.self)
        try? realm?.write {
            realm?.delete((listOfWine?[indexPath.row])!)
        }
    }

//    func deleteWine(item: Wine) {
//        let result = realm.objects(Items.self)
//        realm.delete(result)
//    }
//    func updateTableView(tableView: UITableView) {
//        notificationToken = realm?.observe { note, realm in
//              tableView.reloadData()
//           }
//    }
    
//    func invalidateToken() {
//        notificationToken?.invalidate()
//    }
    
    
    // MARK: тут ошибка trap 6
//    func getListOfWine() -> [RealmWine] {
//        let listOfWine = realm?.objects(RealmWine.self)
//        guard let listOfWine = listOfWine else { return [] }
//        return Array(listOfWine)
//    }
}





