//
//  Friend.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 05.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import Foundation

struct FriendsResponse: Codable {
    let response: FriendsResponseStruct
}

struct FriendsResponseStruct: Codable {
    let count: Int
    let items: [Friend]
}

struct Friend: Codable {
    let id: Int64
    let firstName: String
    let lastName: String
    let avatarUrl: String
    let city: City?
    let birthData: String?

    enum CodingKeys: String, CodingKey {
        case id
        case city
        case firstName  = "first_name"
        case lastName   = "last_name"
        case avatarUrl  = "photo_200"
        case birthData  = "bdate"
    }
}

struct City: Codable {
    let title: String
}
