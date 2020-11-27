//
//  PhotoCell.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 27.11.2020.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let id = "PhotoCell"
    
    let photoImageView = UIImageView()
    let photoService   = PhotoService()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPhotoImageView()
        
        updateConstraintsIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(with photoUrl: String) {
        photoService.downloadPhoto(from: photoUrl, to: photoImageView)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        super.updateConstraints()
    }
    
}
