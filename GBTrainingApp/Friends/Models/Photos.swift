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
    let items: [PhotoItem]
}


struct PhotoItem: Codable {
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}


struct Size: Codable {
    let url: String
}
