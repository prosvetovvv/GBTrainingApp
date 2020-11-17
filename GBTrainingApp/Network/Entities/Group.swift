//
//  Group.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 17.11.2020.
//

import Foundation

struct GroupsResponse: Codable {
    let response: GroupsResponseStruct
}

struct GroupsResponseStruct: Codable {
    let count: Int
    let items: [Group]
}

struct Group: Codable {
    let id: Int64
    let name: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case avatarUrl = "photo_50"
    }
    
}
