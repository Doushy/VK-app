//
//  Photo.swift
//  App VK
//
//  Created by Дима Сторчеус on 07.12.2021.
//

import Foundation
import RealmSwift

struct Photes: Codable {
    let response: ResponsePhotes
}


class ResponsePhotes: Object, Codable {
    @objc dynamic var count: Int = 0
    var items: [ItemPhotes] = []
}


class ItemPhotes: Object, Codable {
    @objc dynamic var id: Int = 0
    var sizes: [Size] = []

}


class Size: Object, Codable {
    //let height: Int
    @objc dynamic var url: String = ""
    //let type: String
    //let width: Int
}



class RealmManagerPhotos {
    
    func saveData(users: [Size]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(users)
            try realm.commitWrite()
            print("__________")
            print("all good")
            print("__________")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
