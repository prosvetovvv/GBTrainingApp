//
//  FriendCell.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 06.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    static let id = "FriendCell"
    
    let photoNetworkService = PhotoNetworkService()
    let avatarImageView     = VKAvatarImageView(frame: .zero)
    let nameTitleLabel      = VKTitleLabel(textAlignment: .left, fontSize: 22)
    let cityTitleLabel      = VKSecondaryTitleLabel(fontSize: 17)
    
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
            
            nameTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -17),
            nameTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            nameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            cityTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17),
            cityTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            cityTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cityTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setup() {
        addSubview(avatarImageView)
        addSubview(nameTitleLabel)
        addSubview(cityTitleLabel)
        
        setNeedsUpdateConstraints()
    }
    
    func set(with friend: MyFriend) {
        self.photoNetworkService.downloadPhoto(from: friend.avatarUrl, to: self.avatarImageView)
        self.nameTitleLabel.text = "\(friend.firstName) \(friend.lastName)"
        self.cityTitleLabel.text = friend.city
    }
}
