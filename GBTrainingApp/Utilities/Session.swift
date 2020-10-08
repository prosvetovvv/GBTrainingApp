//
//  Session.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 28.09.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import Foundation

class Session {
    let login = "user"
    let password = "password"
    var token = ""
    
    static let shared = Session()
    
    private init() {}
}
