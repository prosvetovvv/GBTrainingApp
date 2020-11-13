//
//  TextPhotoCell.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 12.11.2020.
//

import UIKit

class TextAndImageCell: UITableViewCell {

    static let id = "TextPhotocell"
    
    let avatarImageView = VKAvatarImageView(frame: .zero)
    let nameTitleLabel  = VKTitleLabel(textAlignment: .left, fontSize: 22)
    let dateTitleLabel  = VKSecondaryTitleLabel(fontSize: 17)
    let bodyLabel       = VKNewBodyLabel()
    let mainImageView       = UIImageView()
    let itemInfoBar     = VKItemInfoBar()
    
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
        
        setupMainImage()
        
        needsUpdateConstraints()
    }
    
    
    private func setupMainImage() {
        mainImageView.backgroundColor   = .systemGray
        mainImageView.contentMode       = .scaleAspectFit
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainImageView)
    }
    
    func set(new: News, by friend: MyFriend?) {
        DispatchQueue.main.async {
            if let friend = friend {
                NetworkService.shared.downloadAvatar(from: friend.avatarUrl, to: self.avatarImageView)
                self.nameTitleLabel.text = "\(friend.firstName) \(friend.lastName)"
            } else {
                self.avatarImageView.image = self.avatarPlaceholder
                self.nameTitleLabel.text = "Неизвестный автор"
            }
            
            NetworkService.shared.downloadAvatar(from: new.image!, to: self.mainImageView)
            self.dateTitleLabel.text = ConvertService.shared.convertUnixTimeToDate(from: new.date)
            self.bodyLabel.text = new.text
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
            
            mainImageView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: padding),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainImageView.heightAnchor.constraint(equalToConstant: 300),
            
            itemInfoBar.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: padding),
            itemInfoBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            itemInfoBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            itemInfoBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        super.updateConstraints()
    }
}
