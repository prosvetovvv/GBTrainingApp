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
    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items
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
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date, text, comments, likes, reposts, views
        
    }
}


struct Comments: Codable {
    let count: Int16
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct Likes: Codable {
    let count, userLikes, canLike, canPublish: Int16
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes  = "user_likes"
        case canLike    = "can_like"
        case canPublish = "can_publish"
    }
}


struct Views: Codable {
    let count: Int16
}


struct Reposts: Codable {
    let count, userReposted: Int16
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}
