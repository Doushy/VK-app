//
//  Friends.swift
//  App VK
//
//  Created by Дима Сторчеус on 02.12.2021.
//

import Foundation

struct ServerResponse: Codable {
    let response: Response

}

class Response: Codable {
    let count: Int
    let items: [Item]

}

class Item: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case id
            case lastName = "last_name"
        case photo100 = "photo_100"}
}
