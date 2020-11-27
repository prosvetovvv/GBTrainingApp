//
//  InfoFriendView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 29.10.2020.
//

import UIKit

class FriendInfoView: UIView {
    
    let avatarImageView     = VKAvatarImageView(frame: .zero)
    let nameLabel           = VKTitleLabel(textAlignment: .left, fontSize: 25)
    let birthDateImageView  = VKSymbolImageView(symbol: .birthDate)
    let birthDateLabel      = VKSecondaryTitleLabel(fontSize: 18)
    let cityImageView       = VKSymbolImageView(symbol: .city)
    let cityLabel           = VKSecondaryTitleLabel(fontSize: 18)
    
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setNeedsUpdateConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(birthDateImageView)
        addSubview(birthDateLabel)
        addSubview(cityImageView)
        addSubview(cityLabel)
    }
    
    
    override func updateConstraints() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            birthDateImageView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            birthDateImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            birthDateImageView.widthAnchor.constraint(equalToConstant: 20),
            birthDateImageView.heightAnchor.constraint(equalToConstant: 20),
            
            birthDateLabel.centerYAnchor.constraint(equalTo: birthDateImageView.centerYAnchor),
            birthDateLabel.leadingAnchor.constraint(equalTo: birthDateImageView.trailingAnchor, constant: 5),
            birthDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            birthDateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            cityImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            cityImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            cityImageView.widthAnchor.constraint(equalToConstant: 20),
            cityImageView.heightAnchor.constraint(equalToConstant: 20),
            
            cityLabel.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 5),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        super.updateConstraints()
    }
}
