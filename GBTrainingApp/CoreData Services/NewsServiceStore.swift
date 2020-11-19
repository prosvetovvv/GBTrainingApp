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
                
                if new.sourceId < 0 {
                    news.name       = self.getGroupName(by: abs(new.sourceId), from: newsResponse.groups)
                    news.avatarUrl  = self.getGroupAvatarUrl(by: abs(new.sourceId) , from: newsResponse.groups)
                } else {
                    news.name       = self.getFriendName(by: new.sourceId, from: newsResponse.profiles)
                    news.avatarUrl  = self.getGroupAvatarUrl(by: new.sourceId, from: newsResponse.groups)
                }

                if let attachments = new.attachments {
                    news.photos = self.getPhoto(from: attachments)
                } else {
                    news.photos = nil
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
    
    private func getPhoto(from attachments: [ItemAttachment]) -> [String]? {
        var resultArray = [String]()
        for attachment in attachments {
            if  attachment.type == .photo {
                let photo = attachment.photo!.sizes.last!.url
                resultArray.append(photo)
            }
        }
       return resultArray
    }
    
    private func getFriendName(by sourceId: Int64, from profiles: [Profile]) -> String? {
        for item in profiles {
            if sourceId == item.id {
                let name = "\(item.firstName) \(item.lastName)"
                return name
            }
        }
        return nil
    }
    
    private func getGroupName(by sourceId: Int64, from groups: [Group]) -> String? {
        for item in groups {
            if sourceId == item.id {
                let name = item.name
                return name
            }
        }
        return nil
    }
    
    private func getFriendAvatarUrl(by sourceId: Int64, from array: [Profile]) -> String? {
        for item in array {
            if sourceId == item.id {
                let avatarUrl = item.avatarUrl
                return avatarUrl
            }
        }
        return nil
    }
    
    private func getGroupAvatarUrl(by sourceId: Int64, from array: [Group]) -> String? {
        for item in array {
            if abs(sourceId) == item.id {
                let avatarUrl = item.avatarUrl
                return avatarUrl
            }
        }
        return nil
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

