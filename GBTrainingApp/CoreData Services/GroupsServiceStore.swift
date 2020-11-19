//
//  GroupsServiceStore.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 18.11.2020.
//

import CoreData

struct GroupsServiceStore {
    
    let storeStack = CoreDataStack.shared
    
    
    func saveGroups(from arrayGroups: [Group]) {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        privateContext.perform {
            for group in arrayGroups {
                let groups = Groups(context: privateContext)
                
                groups.id           = group.id
                groups.name         = group.name
                groups.avatarUrl    = group.avatarUrl
            }
            
            do {
                try privateContext.save()
                context.performAndWait {
                    storeStack.saveContext()
                }
            } catch { fatalError("Failure to save private context: \(error)") }
        }
    }
    
    
    func clearGroups() {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        let fetchRequest: NSFetchRequest<Groups> = Groups.fetchRequest()
        
        privateContext.perform {
            do {
                let objects = try privateContext.fetch(fetchRequest)
                _ = objects.map{privateContext.delete($0)}
                
                do {
                    try privateContext.save()
                    context.performAndWait {
                        storeStack.saveContext()
                    }
                } catch { fatalError("Failure to save private context: \(error)") }
                
            } catch let error { print("Error fetched: \(error)") }
        }
    }
    
    func getGroup(by groupId: Int64) -> Groups? {
        let context = storeStack.context
        let fetchRequest: NSFetchRequest<Groups> = Groups.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", groupId)
        
        do {
            let fetchResult = try context.fetch(fetchRequest)
            guard !fetchResult.isEmpty else { return nil }
            return fetchResult.first
        } catch { return nil }
    }
    
}
