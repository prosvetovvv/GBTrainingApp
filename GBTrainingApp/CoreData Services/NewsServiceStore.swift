//
//  CoreDateNewsService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 06.11.2020.
//

import Foundation
import CoreData

class NewsServiceStore {
    
    let storeStack = CoreDataStack.shared
    
    enum Date {
        case avatarUrl, name
    }
    
    func saveNews(from newsResponse: NewsResponseStruct) {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        privateContext.perform {
            for new in newsResponse.items {
                let news = News(context: privateContext)
                
                
//                if let attachments = new.attachments, let photo = attachments[0].photo {
//                    let indexPhotoMaxSize = photo.sizes.count - 1
//                    news.image = photo.sizes[indexPhotoMaxSize].url
//                }
                
                if let attachments = new.attachments, !new.attachments!.isEmpty {
                    news.photos = self.getPhotosMaxSize(from: attachments)
                }
                
                news.name = self.getValue(for: .name, by: new.sourceId, from: newsResponse.profiles, or: newsResponse.groups)
                news.avatarUrl = self.getValue(for: .avatarUrl, by: new.sourceId, from: newsResponse.profiles, or: newsResponse.groups)
                
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
    
    
    private func getPhotosMaxSize(from array: [ItemAttachment]) -> [String] {
        var resultArray = [String]()
        
        for allSize in array {
            let maxSize = allSize.photo!.sizes.last
            resultArray.append(maxSize!.url)
        }
        return resultArray
    }
    
    
    private func getValue(for row: Date, by sourceId: Int64, from profiles: [Profile], or groups: [Group]) -> String? {
        var name: String? = nil
        var avatarUrl: String? = nil
        
        for profile in profiles {
            if sourceId == profile.id {
                name = "\(profile.firstName) \(profile.lastName)"
                avatarUrl = profile.avatarUrl
            }
        }
        for group in groups {
            if sourceId == group.id {
                name = group.name
                avatarUrl = group.avatarUrl
            }
        }
        
        switch row {
        case .avatarUrl:
            return avatarUrl
        case .name:
            return name
        }
    }
}

