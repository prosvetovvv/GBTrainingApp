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
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setup()
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
}
