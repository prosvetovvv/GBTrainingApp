//
//  GroupCell.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 17.11.2020.
//

import UIKit

class GroupCell: UITableViewCell {
    
    static let id = "GroupCell"
    let photoService = PhotoService()
    
    let avatarImageView = VKAvatarImageView(frame: .zero)
    let nameTitleLabel  = VKTitleLabel(textAlignment: .left, fontSize: 22)

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
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameTitleLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            nameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        super.updateConstraints()
    }
    
    func set(with group: Groups) {
        DispatchQueue.main.async {
            self.photoService.downloadPhoto(from: group.avatarUrl, to: self.avatarImageView)
            self.nameTitleLabel.text = group.name
        }
    }

}
