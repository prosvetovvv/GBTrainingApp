//
//  Photos.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 30.10.2020.
//

import Foundation

struct PhotosResponse: Codable {
    let response: PhotosResponseStruct
}


struct PhotosResponseStruct: Codable {
    let count: Int
    let items: [Item]
}


struct Item: Codable {
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}


struct Size: Codable {
    let url: String
    let type: TypeEnum
}


enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
