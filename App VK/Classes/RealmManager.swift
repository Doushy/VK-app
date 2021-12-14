//
//  RealmManager.swift
//  App VK
//
//  Created by Дима Сторчеус on 14.12.2021.
//

import Foundation
import RealmSwift
import Realm


class RealmManager {
    
    func saveData<T: Object>(data: [T]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(data)
            //                realm.add(data, update: .all)
            try realm.commitWrite()
            print("Save successful")
            print(realm.configuration.fileURL)
        } catch {
            print(error)
        }
    }
    
    func getData<T: Object>() -> [T] {
        let realm = try! Realm()
        let listFriends = realm.objects(T.self)
        //        print(listFriends)
        return Array(listFriends)
    }
}
