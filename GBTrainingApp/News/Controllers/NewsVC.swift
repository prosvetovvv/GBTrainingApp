//
//  NewsVC.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 02.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit
import CoreData

class NewsVC: UIViewController {
    
    let rootView = NewsView()
    var fetchedNewsRC: NSFetchedResultsController<News>!
    var fetchedFriendRC: NSFetchedResultsController<MyFriend>!
    var dataSource: UITableViewDiffableDataSource<Int, News>!
    
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupFetchedNewsRC()
        setupTableView()
        updateTableContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor     = .clear
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Settings
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupTableView() {
        rootView.tableView.register(NewCell.self, forCellReuseIdentifier: NewCell.id)
        dataSource = UITableViewDiffableDataSource<Int, News>(tableView: rootView.tableView, cellProvider: { (tableView, indexPath, new) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewCell.id, for: indexPath) as! NewCell
            cell.set(with: new)
            return cell
        })
        updateSnapshot()
    }
    
    
    // MARK: - CoreData
    
    private func setupFetchedNewsRC() {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(News.date), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        fetchedNewsRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedNewsRC.delegate = self
        
        do {
            try fetchedNewsRC.performFetch()
            updateSnapshot()
        } catch {
            print("Fetch failed")
        }
    }
    
        
    
    // MARK: - Update Data
    
    private func updateTableContent() {
        do {
            try fetchedNewsRC.performFetch()
            print("Count fetched News: \(String(describing: fetchedNewsRC.sections?[0].numberOfObjects))")
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        getNewsFromNetwork()
    }
    
    
    private func updateSnapshot() {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, News>()
        dataSourceSnapshot.appendSections([0])
        dataSourceSnapshot.appendItems(fetchedNewsRC.fetchedObjects ?? [])
        DispatchQueue.main.async { self.dataSource.apply(dataSourceSnapshot, animatingDifferences: true)}
    }
    
    
    // MARK: - Network
    
    private func  getNewsFromNetwork() {
        NetworkService.shared.getNews() { result in
            switch result {
            
            case .success(let news):
                CoreDataNewsService.shared.clearNews()
                CoreDataNewsService.shared.saveNews(from: news)
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}


// MARK: - Extensions

extension NewsVC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}



