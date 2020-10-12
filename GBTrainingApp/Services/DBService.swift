//
//  File.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 08.10.2020.
//

import UIKit

class DBService {
    
    let storeStack = CoreDataStack(modelName: "GBTrainingApp")
    
    func saveFriend(userId: String, firstName: String, lastName: String, activity: String, avatarUrl: String?) {
        let context = storeStack.context
        let friend = MyFriend(context: context)
        
        friend.userId = userId
        friend.firstName = firstName
        friend.lastName = lastName
        friend.activity = activity
        friend.avatarUrl = avatarUrl
        
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
