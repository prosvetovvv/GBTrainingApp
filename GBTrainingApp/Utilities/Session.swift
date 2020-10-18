//
//  Session.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 28.09.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import Foundation

class Session {
    var token = ""
    static let shared = Session()
    
    private init() {}
}
