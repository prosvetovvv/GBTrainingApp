//
//  File.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 08.10.2020.
//

import UIKit
import CoreData

struct CoreDataFriendsService {
    
    static let shared = CoreDataFriendsService()
    let storeStack    = CoreDataStack.shared
    
    private init() {}
    
    
    func saveFriendInPrivateQueue(from arrayFriends: [Friend]) {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        privateContext.perform {
            for friend in arrayFriends {
                if friend.firstName == "DELETED" { continue }
                let myFriend = MyFriend(context: privateContext)
                
                myFriend.id         = friend.id
                myFriend.firstName  = friend.firstName
                myFriend.lastName   = friend.lastName
                myFriend.city       = friend.city?.title
                myFriend.avatarUrl  = friend.avatarUrl
                myFriend.birthDate  = friend.birthData
            }
            
            do {
                try privateContext.save()
                context.performAndWait {
                    storeStack.saveContext()
                }
            } catch { fatalError("Failure to save private context: \(error)") }
        }
    }
    
    
    func clearFriendsInPrivateQueue() {
        let context = storeStack.context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        let fetchRequest: NSFetchRequest<MyFriend> = MyFriend.fetchRequest()
        
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
    
    
    func getFriend(by friendId: Int64) -> MyFriend? {
        let context = storeStack.context
        let fetchRequest: NSFetchRequest<MyFriend> = MyFriend.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", friendId)
        
        do {
            let fetchedResult = try context.fetch(fetchRequest)
            guard !fetchedResult.isEmpty else { return nil }
            return fetchedResult[0]
        } catch { return nil }
        
    }
    
    
    func savePhoto(userId: String, photoUrl: String) {
        let context = storeStack.context
        let photo = Photo(context: context)
        
        photo.userId = userId
        photo.photoUrl = photoUrl
        
        storeStack.saveContext()
    }
    
    
    func saveGroup(groupId: String, name: String, activity: String) {
        let context = storeStack.context
        let group = Group(context: context)
        
        group.groupId = groupId
        group.name = name
        group.activity = activity
        
        storeStack.saveContext()
    }
    
    
    func readFriendList() -> [MyFriend] {
        let context = storeStack.context
        
        return (try? context.fetch(MyFriend.fetchRequest()) as? [MyFriend]) ?? []
    }
    
    
    func readPhotoList() -> [Photo] {
        let context = storeStack.context
        
        return (try? context.fetch(Photo.fetchRequest()) as? [Photo]) ?? []
    }
    
    
    func readGroupList() -> [Group] {
        let context = storeStack.context
        
        return (try? context.fetch(Group.fetchRequest()) as? [Group]) ?? []
    }
}
