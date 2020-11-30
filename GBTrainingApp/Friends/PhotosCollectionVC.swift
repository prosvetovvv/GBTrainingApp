//
//  PhotosCollectionVC.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 27.11.2020.
//

import UIKit

class PhotosCollectionVC: UICollectionViewController {
    
    var friend: MyFriend?
    var photos = [String]()
    let photoNetworkService = PhotoNetworkService()
    let friendsNetworkService  = FriendsNetworkService()
    
    var layout: UICollectionViewFlowLayout {
        let _layout = UICollectionViewFlowLayout()
        _layout.scrollDirection = .horizontal
        return _layout
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupSelf()
        if let friendId = friend?.id {
            getPhotoFromNetwork(for: String(friendId))
        }
    }
    
    private func setupSelf() {
        super.viewDidLoad()

        self.collectionView.collectionViewLayout    = layout
        self.collectionView.isPagingEnabled         = true
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.id)
    }
    
    private func getPhotoFromNetwork(for friend: String) {
        
        friendsNetworkService.getPhotos(for: friend) { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let photos):
                self.getPhotosMaxSize(from: photos)
                DispatchQueue.main.async { self.collectionView.reloadData() }
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func getPhotosMaxSize(from allPhotos: PhotosResponseStruct) {
        for photo in allPhotos.items {
            guard let maxSizePhoto =  photo.sizes.last?.url else { continue }
            photos.append(maxSizePhoto)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.id, for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        cell.set(with: photo)
        return cell
    }
}

// MARK: - Extensions

extension PhotosCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
