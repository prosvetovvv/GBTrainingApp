//
//  File.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 08.10.2020.
//

import UIKit
import CoreData

class DBService {
    
    static let shared = DBService()
    let storeStack    = CoreDataStack.shared
    
    private init() {}
    
    
    func save(friends: [Friend]) {
        let context = storeStack.context
        
        for friend in friends {
            let myFriend = MyFriend(context: context)
            
            myFriend.id        = friend.id
            myFriend.firstName = friend.firstName
            myFriend.lastName  = friend.lastName
            myFriend.city      = friend.city?.title
            myFriend.avatarUrl = friend.avatarUrl
        }
        storeStack.saveContext()
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
