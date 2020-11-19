//
//  New.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 03.11.2020.
//

import Foundation

struct NewsResponse: Codable {
    let response: NewsResponseStruct
}

struct NewsResponseStruct: Codable {
    let items: [New]
    let profiles: [Profile]
    let groups: [Group]
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

struct New: Codable {
    let sourceId: Int64
    let date: Int64
    let text: String?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let attachments: [ItemAttachment]?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date, text, comments, likes, reposts, views, attachments
    }
}

struct Comments: Codable {
    let count: Int64
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct Likes: Codable {
    let count: Int64
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct Views: Codable {
    let count: Int64
}

struct Reposts: Codable {
    let count: Int64
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct ItemAttachment: Codable {
    let type: AttachmentType
    let photo: PhotoItem?
}

enum AttachmentType: String, Codable {
    case audio = "audio"
        case link = "link"
        case photo = "photo"
        case video = "video"
}

struct Profile: Codable {
    let firstName: String
    let id: Int64
    let lastName: String
    let avatarUrl: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case firstName  = "first_name"
        case lastName   = "last_name"
        case avatarUrl  = "photo_50"
    }
}
