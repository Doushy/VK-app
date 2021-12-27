//
//  Groups.swift
//  App VK
//
//  Created by Дима Сторчеус on 07.12.2021.
//

import Foundation
import RealmSwift
import Realm

@objcMembers
class Groups: Object, Codable {
    dynamic var response: GroupResponse? = nil

}

@objcMembers
class GroupResponse: Object, Codable {
    dynamic var count: Int = 0
    dynamic var items = List<GroupsInfo>()

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        count = try container.decode(Int.self, forKey: .count)
        let itemsList = try container.decode([GroupsInfo].self, forKey: .items)
        items.append(objectsIn: itemsList)
        super.init()
    }
    
    required override init() {
        super.init()
    }
}
@objcMembers
class GroupsInfo: Object, Codable {
    dynamic var  name: String = ""
    dynamic var  id: Int = 0
    dynamic var  photo50: String = ""

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id
        case photo50 = "photo_50"
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}

