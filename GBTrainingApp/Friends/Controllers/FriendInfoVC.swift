//
//  FriendInfoVC.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 28.10.2020.
//

import UIKit

class FriendInfoVC: UIViewController {
        
    let rootView = FriendInfoView()
    
    var friend: MyFriend!
    var photos: PhotosResponseStruct?
    var photosMaxSize = [String]()
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setup()
        
        print("HELLO")
        print("HELLO1")
        
        getPhotoFromNetwork(for: String(friend.id))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor        = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = false
    }
    
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        
    }
    
    
    private func setup() {
        NetworkService.shared.downloadAvatar(from: friend.avatarUrl, to: rootView.avatarImageView)
        rootView.nameLabel.text           = "\(friend.firstName) \(friend.lastName)"
        rootView.birthDateLabel.text      = friend.birthDate ?? ""
        rootView.cityLabel.text           = friend.city
    }
    
    
    private func getPhotoFromNetwork(for friend: String) {
        
        NetworkService.shared.getPhotos(for: friend) { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let photos):
                self.getPhotosMaxSize(from: photos)
                print(photos.count)
                print(self.photosMaxSize)
                

            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    private func getPhotosMaxSize(from allPhotos: PhotosResponseStruct) {
        for photos in allPhotos.items {
            let i = photos.sizes.count
            photosMaxSize.append(photos.sizes[i - 1].url)
        }
    }
    
}
