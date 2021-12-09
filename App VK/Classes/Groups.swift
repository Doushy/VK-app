//
//  Groups.swift
//  App VK
//
//  Created by Дима Сторчеус on 07.12.2021.
//

import Foundation
import RealmSwift

struct GroupsResponseGroup: Codable {
    let response: ResponseGroup

}

class ResponseGroup: Object, Codable {
    @objc dynamic var count: Int = 0
    var items: [ItemGroup] = []

}

class ItemGroup: Object, Codable {
    @objc dynamic var  name: String = ""
    @objc dynamic var  id: Int = 0
    @objc dynamic var  photo50: String = ""

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id
        case photo50 = "photo_50"}
}

class RealmManagerGroups {
    
    func saveData(users: [ItemGroup]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(users)
            try realm.commitWrite()
            
            print("_____________")
            print("all good")
            print("_____________")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
