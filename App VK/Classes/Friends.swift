//
//  Friends.swift
//  App VK
//
//  Created by Дима Сторчеус on 02.12.2021.
//

import Foundation
import RealmSwift
import Realm

@objcMembers
class Friends: Object, Codable {
    dynamic var response: FriendsResponse? = nil
}

@objcMembers
class FriendsResponse: Object,  Codable {
    dynamic var count: Int = 0
    dynamic var items = List<FriendInfo>()
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        count = try container.decode(Int.self, forKey: .count)
        let itemsList = try container.decode([FriendInfo].self, forKey: .items)
        items.append(objectsIn: itemsList)
        super.init()
    }
    
    required override init() {
        super.init()
    }
    
}

@objcMembers
class FriendInfo: Object, Codable {
    dynamic var firstName: String = ""
    dynamic var id: Int = 0
    dynamic var lastName: String = ""
    dynamic var photo100: String = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo100 = "photo_100"
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}


//class RealmManagerFriends {
//    
//    func saveData(users: [FriendInfo]) {
//        do {
//            let realm = try Realm()
//            realm.beginWrite()
//            realm.add(users)
//            try realm.commitWrite()
//            print("all good")
//            print(realm.configuration.fileURL)
//            //            print(realm)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
    
    
    
//}
