//
//  Session.swift
//  App VK
//
//  Created by Дима Сторчеус on 23.11.2021.
//

import Foundation

class VKSession {
    
    private init () {}
    
    static let instance = VKSession()
    
    var token: String = ""
    var userId: Int = 0
    
}
