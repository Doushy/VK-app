//
//  Groups.swift
//  App VK
//
//  Created by Дима Сторчеус on 07.12.2021.
//

import Foundation

struct GroupsResponseGroup: Codable {
    let response: ResponseGroup

}

class ResponseGroup: Codable {
    let count: Int
    let items: [ItemGroup]

}

class ItemGroup: Codable {
    let name: String
    let id: Int
    let photo50: String

    enum CodingKeys: String, CodingKey {
            case name = "name"
            case id
        case photo50 = "photo_50"}
}
