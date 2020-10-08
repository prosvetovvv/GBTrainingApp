//
//  AvatarImageView.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 06.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
