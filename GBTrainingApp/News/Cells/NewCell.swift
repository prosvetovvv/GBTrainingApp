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
    
    let photoService    = PhotoService()
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
        addSubview(itemInfoBar)
        
        setupScrollView()
        setupContainerView()
        
        needsUpdateConstraints()
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .systemTeal
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
    }
    
    private func setupContainerView() {
        containerView.backgroundColor = .systemPink
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(bodyLabel)
        
        scrollView.addSubview(containerView)
    }
    
    
    func set(new: News, by friend: MyFriend?) {
        
        
        DispatchQueue.main.async {
            if let friend = friend {
                self.photoService.downloadPhoto(from: friend.avatarUrl, to: self.avatarImageView)
                self.nameTitleLabel.text = "\(friend.firstName) \(friend.lastName)"
            } else {
                self.avatarImageView.image = self.avatarPlaceholder
                self.nameTitleLabel.text = "Неизвестный"
            }
            self.dateTitleLabel.text = self.convertDateService.convertUnixTime(from: new.date)
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
            
            scrollView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            scrollView.bottomAnchor.constraint(equalTo: itemInfoBar.topAnchor, constant: -padding),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            itemInfoBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            itemInfoBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            itemInfoBar.heightAnchor.constraint(equalToConstant: 20),
            itemInfoBar.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10)
        ])
        super.updateConstraints()
    }
    
}
