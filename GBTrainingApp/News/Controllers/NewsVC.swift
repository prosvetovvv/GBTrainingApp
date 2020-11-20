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
    let newsService = NewsService()
    let friendsServiceStore = FriendsServiceStore()
    let newsServiceStore = NewsServiceStore()
    
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupTableView()
        setupFetchedNewsRC()
        getNewsFromNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor     = .clear
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Settings
    
    private func setupSelf() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupTableView() {
        rootView.tableView.register(NewCell.self, forCellReuseIdentifier: NewCell.id)
        rootView.tableView.register(TextAndImageCell.self, forCellReuseIdentifier: TextAndImageCell.id)
        rootView.tableView.dataSource = self
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
            print("Count fetched News: \(String(describing: fetchedNewsRC.sections?[0].numberOfObjects))")
        } catch {
            print("Fetch failed")
        }
    }
    
    
    // MARK: - Network
    
    private func  getNewsFromNetwork() {
        newsService.getNews() { [ unowned self ] result in
            switch result {
            
            case .success(let newsResponse):
                self.newsServiceStore.clearNews()
                self.newsServiceStore.saveNews(from: newsResponse)
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}


// MARK: - Extensions

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedNewsRC.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = fetchedNewsRC.object(at: indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: TextAndImageCell.id, for: indexPath) as! TextAndImageCell
            cell.set(new: new)
            
            return cell
    }
}


extension NewsVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            rootView.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            rootView.tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        rootView.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        rootView.tableView.endUpdates()
    }
}
