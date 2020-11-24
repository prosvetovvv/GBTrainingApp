//
//  TextPhotoCell.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 12.11.2020.
//

import UIKit

class TextAndImageCell: UITableViewCell {
    
    static let id = "TextAndImageCell"
    
    let padding: CGFloat            = 20
    let textImagePadding: CGFloat   = 12
    
    let avatarImageView     = VKAvatarImageView(frame: .zero)
    let nameTitleLabel      = VKTitleLabel(textAlignment: .left, fontSize: 22)
    let dateTitleLabel      = VKSecondaryTitleLabel(fontSize: 17)
    let bodyLabel           = VKNewBodyLabel()
    let mainImageView       = UIImageView()
    let photosStackView     = UIStackView()
    //var arrPhoto            = [UIImageView]()
    let itemInfoBar         = VKItemInfoBar()
    
    let photoService        = PhotoService()
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
        
        setupAvatarImageView()
        //setupPhotosStackView()
        setupMainImage()
        
        needsUpdateConstraints()
    }
    
    private func setupAvatarImageView() {
        avatarImageView.image = avatarPlaceholder
    }
    
    private func setupMainImage() {
        mainImageView.backgroundColor   = .systemGray
        mainImageView.contentMode       = .scaleAspectFit
        mainImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainImageView)
    }
    
    private func setupPhotosStackView() {
        photosStackView.spacing     = 10
        //photosStackView.alignment   = .center
        photosStackView.distribution = .fillEqually
        photosStackView.axis        = NSLayoutConstraint.Axis.horizontal
        photosStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(photosStackView)
    }
        
    func set(new: News) {
        //DispatchQueue.main.async {
            if let avatarUrl = new.avatarUrl {
                self.photoService.downloadPhoto(from: avatarUrl, to: self.avatarImageView)
            }
        if let photo = new.photos.first {
            photoService.downloadPhoto(from: photo, to: mainImageView)
        }
            //self.addPhotoToStackView(from: new.photos)
        
//                let image = UIImageView(image: self.avatarPlaceholder)
//                self.photosStackView.addArrangedSubview(image)
            
            self.nameTitleLabel.text    = new.name
            self.bodyLabel.text         = new.text ?? "!!!!!!!!!"
            self.dateTitleLabel.text    = self.convertDateService.convertUnixTime(from: new.date)
            self.itemInfoBar.set(with: new)
        //}
    }
        
    private func addPhotoToStackView(from photos: [String]) {
        var arrPhoto = [UIImageView]()
        debugPrint("Before remove stack: ", photosStackView.arrangedSubviews.count)
        
        for photo in photos {
            let photoImageView = UIImageView()
            self.photoService.downloadPhoto(from: photo, to: photoImageView)
            photosStackView.addSubview(photoImageView)
            //arrPhoto.append(photoImageView)
            debugPrint("Photos in stack: ", photosStackView.arrangedSubviews.count)
        }
//        debugPrint("Photos in stack: ", arrPhoto.count, arrPhoto)
//        for view in arrPhoto {
//            photosStackView.addArrangedSubview(view)
//        }
    }

    override func updateConstraints() {
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
            
//            photosStackView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: padding),
//            photosStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
//            photosStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
//            photosStackView.heightAnchor.constraint(equalToConstant: 300),
            
            itemInfoBar.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: padding),
            itemInfoBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            itemInfoBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            itemInfoBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
        super.updateConstraints()
    }
}
