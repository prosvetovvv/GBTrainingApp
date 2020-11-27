//
//  GroupsVC.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 18.11.2020.
//

import UIKit
import CoreData

class GroupsVC: UIViewController {
    
    var fetchedGroupsRC: NSFetchedResultsController<Groups>!
    var fetchedFriendRC: NSFetchedResultsController<Groups>!
    let rootView            = GroupsView()
    let groupService        = GroupsService()
    let groupServiceStore   = GroupsServiceStore()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupTableView()
        setupFetchedGroupsRC()
        getGroupsFromNetwork()

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
        rootView.tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.id)
        rootView.tableView.dataSource = self
    }
    
    // MARK: - Core Data
    
    private func setupFetchedGroupsRC() {
        let fetchRequest: NSFetchRequest<Groups> = Groups.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Groups.name), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        fetchedGroupsRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedGroupsRC.delegate = self
        
        do {
            try fetchedGroupsRC.performFetch().self
            print("Count fetched groups: \(String(describing: fetchedGroupsRC.sections?[0].numberOfObjects))")
        } catch {
            print("Fetch failed")
        }
    }
    
    // MARK: - Network
    
    private func getGroupsFromNetwork() {
        groupService.getGroups { [ unowned self ] result in
            switch result {
            case .success(let groups):
                self.groupServiceStore.clearGroups()
                self.groupServiceStore.saveGroups(from: groups)
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

}

// MARK: - Extensions

extension GroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedGroupsRC.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = fetchedGroupsRC.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.id, for: indexPath) as! GroupCell
        cell.set(with: group)
        
        return cell
    }
}

extension GroupsVC: NSFetchedResultsControllerDelegate {
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
