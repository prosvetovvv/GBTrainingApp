//
//  FriendCell.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 06.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    let avatarImageView = AvatarImageView(frame: .zero)
    let nameTitleLabel  = NameTitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            nameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameTitleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    private func setup() {
        addSubview(avatarImageView)
        addSubview(nameTitleLabel)
        
        setNeedsUpdateConstraints()
    }
    
    
    func set(friend: Friend) {
        nameTitleLabel.text = "\(friend.lastName) \(friend.firstName)"
        //avatarImageView.downloadAvatar(from: friend.avatarUrl)
        NetworkManager.shared.downloadAvatar(from: friend.avatarUrl, to: avatarImageView)
    }
}
