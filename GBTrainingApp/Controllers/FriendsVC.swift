//
//  FriendsVC.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 02.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit

class FriendsVC: UIViewController {
    
    let rootView = FriendsView()
    var friends  = [Friend]()
    
    struct Cells {
        static let friendCell = "FriendCell"
    }
    
    
    override func loadView() {
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFriends()
        setupViewController()
        configureTableView()
        setTableViewDelegates()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        rootView.tableView.register(FriendCell.self, forCellReuseIdentifier: Cells.friendCell)
    }
    
    
    private func setTableViewDelegates() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    
    private func getFriends() {
        NetworkManager.shared.getFriends() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let friends):
                self.friends = friends
                DispatchQueue.main.async { self.rootView.tableView.reloadData() }
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

extension FriendsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.friendCell) as! FriendCell
        let friend = friends[indexPath.row]
        cell.set(friend: friend)
        
        return cell
    }
}




