//
//  CoreDateNewsService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 06.11.2020.
//

import Foundation
import CoreData

class NewsServiceStore {
    
    let storeStack    = CoreDataStack.shared
    
    
    func saveNews(from arrayNews: [New]) {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        privateContext.perform {
            for new in arrayNews {
                let news = News(context: privateContext)
                
                
                if let attachments = new.attachments, let photo = attachments[0].photo {
                    let indexPhotoMaxSize = photo.sizes.count - 1
                    news.image = photo.sizes[indexPhotoMaxSize].url
                }
                
                news.sourceId   = new.sourceId
                news.date       = new.date
                news.text       = new.text
                news.likes      = new.likes?.count ?? 0
                news.comments   = new.comments?.count ?? 0
                news.reposts    = new.reposts?.count ?? 0
                news.show       = new.views?.count ?? 0
            }
            
            do {
                try privateContext.save()
                context.performAndWait {
                    self.storeStack.saveContext()
                }
            } catch { fatalError("Failure to save private context: \(error)") }
        }
    }
    
    
    func clearNews() {
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

