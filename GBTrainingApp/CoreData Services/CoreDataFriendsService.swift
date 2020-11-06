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
    
    
    func saveFriends(from arrayFriends: [Friend]) {
        let context = storeStack.context
        
        for friend in arrayFriends {
            if friend.firstName == "DELETED" { continue }
            let myFriend = MyFriend(context: context)
            
            myFriend.id         = friend.id
            myFriend.firstName  = friend.firstName
            myFriend.lastName   = friend.lastName
            myFriend.city       = friend.city?.title
            myFriend.avatarUrl  = friend.avatarUrl
            myFriend.birthDate  = friend.birthData
        }
        storeStack.saveContext()
    }
    
    
    func clearFriends() {
        let context = storeStack.context
        let fetchRequest: NSFetchRequest<MyFriend> = MyFriend.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            _ = objects.map{context.delete($0)}
            storeStack.saveContext()
        } catch let error {
            print("Error deleting: \(error)")
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
