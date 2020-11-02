//
//  NewCell.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 02.11.2020.
//

import UIKit

class NewCell: UITableViewCell {
    
    static let id = "NewCell"
    
    let avatarImageView = VKAvatarImageView(frame: .zero)
    let nameTitleLabel  = VKTitleLabel(textAlignment: .left, fontSize: 22)
    let timeTitleLabel  = VKSecondaryTitleLabel(fontSize: 17)
    let bodyLabel       = VKBodyLabel(textAlignment: .right)
    let scrollView      = UIScrollView()
    let containerView   = UIView()
    let itemInfoBar     = VKItemInfoBar()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    private func setup() {
        addSubview(avatarImageView)
        addSubview(nameTitleLabel)
        addSubview(timeTitleLabel)
        addSubview(itemInfoBar)
        
        scrollView.addSubview(containerView)
        containerView.addSubview(bodyLabel)
        
        needsUpdateConstraints()
    }
    
    
    func set() {
        
    }
    
        
    override func updateConstraints() {
        super.updateConstraints()
        
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            nameTitleLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -17),
            nameTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            timeTitleLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 17),
            timeTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            timeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            timeTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            scrollView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            scrollView.bottomAnchor.constraint(equalTo: itemInfoBar.topAnchor, constant: -padding),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            
            itemInfoBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            itemInfoBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            itemInfoBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
