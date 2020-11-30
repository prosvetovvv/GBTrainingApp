//
//  NewCell.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 02.11.2020.
//

import UIKit

class NewCell: UITableViewCell {
    
    static let id = "NewCell"
    
    let avatarImageView     = VKAvatarImageView(frame: .zero)
    let nameTitleLabel      = VKTitleLabel(textAlignment: .left, fontSize: 22)
    let dateTitleLabel      = VKSecondaryTitleLabel(fontSize: 17)
    let bodyLabel           = VKNewBodyLabel()
    let scrollView          = UIScrollView()
    let containerView       = UIView()
    let itemInfoBar         = VKItemInfoBar()
    
    let photoService    = PhotoNetworkService()
    let convertDateService  = ConvertDateService()
    
    let avatarPlaceholder: UIImage = UIImage(named: "placeholder")!
    
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
        addSubview(dateTitleLabel)
        addSubview(bodyLabel)
        addSubview(itemInfoBar)
        
        needsUpdateConstraints()
    }
    
    func set(new: News) {
        DispatchQueue.main.async {
            if let avatarUrl = new.avatarUrl {
                self.photoService.downloadPhoto(from: avatarUrl, to: self.avatarImageView)
            }
            self.nameTitleLabel.text    = new.name
            self.bodyLabel.text         = new.text
            self.dateTitleLabel.text    = self.convertDateService.convertUnixTime(from: new.date)
            self.itemInfoBar.set(with: new)
        }
    }
    
    override func updateConstraints() {
        
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
            
            dateTitleLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 17),
            dateTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            dateTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            dateTitleLabel.heightAnchor.constraint(equalToConstant: 40),
                        
            bodyLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            bodyLabel.heightAnchor.constraint(equalToConstant: 50),
            
            itemInfoBar.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: padding),
            itemInfoBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            itemInfoBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            itemInfoBar.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -30)
        ])
        super.updateConstraints()
    }
    
}
