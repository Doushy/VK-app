//
//  Friends.swift
//  App VK
//
//  Created by Дима Сторчеус on 02.12.2021.
//

import Foundation
import RealmSwift

struct ServerResponse: Codable {
    let response: Response

}

class Response: Object,  Codable {
    @objc dynamic var count: Int = 0
    var items: [Item] = []

}

class Item: Object, Codable {
    @objc dynamic var firstName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo100: String = ""

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo100 = "photo_100"}
}


class RealmManagerFriends {
    
    func saveData(users: [Item]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(users)
            try realm.commitWrite()
            print("all good")
//            print(realm)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
