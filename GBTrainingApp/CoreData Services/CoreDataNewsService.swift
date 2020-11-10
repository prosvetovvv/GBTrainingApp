//
//  CoreDateNewsService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 06.11.2020.
//

import Foundation
import CoreData

class CoreDataNewsService {
    
    static let shared = CoreDataNewsService()
    let storeStack    = CoreDataStack.shared
    
    
    private init() {}
    
    
    func saveNewsInPrivateQueue(from arrayNews: [New]) {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        privateContext.perform {
            for new in arrayNews {
                let news = News(context: privateContext)
                
                news.sourceId = new.sourceId
                news.date = new.date
                news.text = new.text
                news.likes = new.likes?.count ?? 0
                news.comments = new.comments?.count ?? 0
                news.reposts = new.reposts?.count ?? 0
                news.show = new.views?.count ?? 0
            }
            
            do {
                try privateContext.save()
                context.performAndWait {
                    self.storeStack.saveContext()
                }
            } catch { fatalError("Failure to save private context: \(error)") }
        }
    }
    
    
    func clearNewsInPrivateQueue() {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        
        privateContext.perform {
            do {
                let objects = try privateContext.fetch(fetchRequest)
                _ = objects.map{privateContext.delete($0)}
                
                do {
                    try privateContext.save()
                    context.performAndWait {
                        self.storeStack.saveContext()
                    }
                } catch { fatalError("Failure to save private context: \(error)") }
                
            } catch let error { print("Error fetched: \(error)") }
        }
    }
}

