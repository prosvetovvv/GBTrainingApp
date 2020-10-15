//
//  FriendsVC.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 02.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit
import CoreData

class FriendsVC: UIViewController {
    
    let rootView = FriendsView()
    
    lazy var fetchedResultsController: NSFetchedResultsController<MyFriend> = {
        let fetchRequest: NSFetchRequest<MyFriend> = MyFriend.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(MyFriend.lastName), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.context, sectionNameKeyPath: nil, cacheName: nil)

        return fetchedResultsController
    }()
    
    struct Cells {
        static let friendCell = "FriendCell"
    }
    
    
    override func loadView() {
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Session.shared.token)
        setupViewController()
        setupTableView()
        setTableViewDelegates()
        updateTableContent()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupTableView() {
        rootView.tableView.register(FriendCell.self, forCellReuseIdentifier: Cells.friendCell)
    }
    
    
    private func setTableViewDelegates() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    
    private func updateTableContent() {
        do {
            try fetchedResultsController.performFetch()
            print("Count fetched: \(String(describing: fetchedResultsController.sections?[0].numberOfObjects))")
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        
        NetworkService.shared.getFriends() { result in
            switch result {
            
            case .success(let friends):
                DBService.shared.save(friends: friends)
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

extension FriendsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.friendCell, for: indexPath) as! FriendCell
        let friend = fetchedResultsController.object(at: indexPath)
        cell.setCell(with: friend)
        
        return cell
    }
}





