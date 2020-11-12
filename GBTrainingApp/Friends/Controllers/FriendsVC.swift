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
    var currentSearchText = ""
    var fetchedResultsController: NSFetchedResultsController<MyFriend>!
    var dataSource: UITableViewDiffableDataSource<Int, MyFriend>!
    
    
    override func loadView() {
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Session.shared.token)
        
        setupViewController()
        setupSearchController()
        setTableViewDelegate()
        
        setupFetchedResultController()
        
        setupTableView()
        updateTableContent()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor     = .clear
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Settings
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Введите имя"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    private func setTableViewDelegate() {
        rootView.tableView.delegate = self
    }
    
    //MARK: - Core Data
    
    private func setupFetchedResultController() {
        let fetchRequest: NSFetchRequest<MyFriend> = MyFriend.fetchRequest()
        
        if !currentSearchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "firstName CONTAINS[c] %@ OR lastName CONTAINS[c] %@", currentSearchText, currentSearchText)
        }
        
        let sort = NSSortDescriptor(key: #keyPath(MyFriend.lastName), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            updateSnapshot()
        } catch {
            print("Fetch failed")
        }
    }
    
    //MARK: - Table View
    
    private func setupTableView() {
        rootView.tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.id)
        dataSource = UITableViewDiffableDataSource<Int, MyFriend>(tableView: rootView.tableView, cellProvider: { (tableView, indexPath, friend) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.id, for: indexPath) as! FriendCell
            cell.set(with: friend)
            return cell
        })
        updateSnapshot()
    }
    
    
    private func updateTableContent() {
        do {
            try fetchedResultsController.performFetch()
            print("Count fetched: \(String(describing: fetchedResultsController.sections?[0].numberOfObjects))")
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        
        getFriendsFromNetwork()
    }
    
    
    private func updateSnapshot() {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, MyFriend>()
        dataSourceSnapshot.appendSections([0])
        dataSourceSnapshot.appendItems(fetchedResultsController.fetchedObjects ?? [])
        DispatchQueue.main.async { self.dataSource.apply(dataSourceSnapshot, animatingDifferences: true) }
    }
    
    //MARK: - Network
    
    private func getFriendsFromNetwork() {
        NetworkService.shared.getFriends() { result in
            switch result {
            
            case .success(let friends):
                CoreDataFriendsService.shared.clearFriendsInPrivateQueue()
                CoreDataFriendsService.shared.saveFriendInPrivateQueue(from: friends)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

//MARK: - Extensions

extension FriendsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let friend = fetchedResultsController.fetchedObjects?[indexPath.row] else{ return }
        
        let destVC = FriendInfoVC()
        destVC.modalPresentationStyle = .fullScreen
        destVC.friend = friend
        navigationController?.pushViewController(destVC, animated: true)
    }
}


extension FriendsVC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}


extension FriendsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        currentSearchText = text
        setupFetchedResultController()
    }
}





