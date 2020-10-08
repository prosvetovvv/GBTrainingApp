//
//  Friend.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 05.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import Foundation

struct FriendsResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let count: Int
    let items: [Friend]
}

struct Friend: Codable {
    let firstName: String
    let lastName: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarUrl = "photo_100"
    }
}
