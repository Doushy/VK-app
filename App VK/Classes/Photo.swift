//
//  Photo.swift
//  App VK
//
//  Created by Дима Сторчеус on 07.12.2021.
//

import Foundation


struct Photes: Codable {
    let response: ResponsePhotes
}


struct ResponsePhotes: Codable {
    let count: Int
    let items: [ItemPhotes]
}


struct ItemPhotes: Codable {
    let id: Int
    let sizes: [Size]

}


struct Size: Codable {
    //let height: Int
    let url: String
    //let type: String
    //let width: Int
}
