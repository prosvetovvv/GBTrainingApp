//
//  TabbarController.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 02.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createFriendsNC(), createGroupsNC(), createNewsNC()]
    }
    
    func createFriendsNC() -> UINavigationController {
        let friendsVC = FriendsVC()
        friendsVC.title = "Friends"
        friendsVC.tabBarItem = UITabBarItem(title: "Friends", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        
        return UINavigationController(rootViewController: friendsVC)
    }
    
    func createGroupsNC() -> UINavigationController {
        let groupsVC = GroupsVC()
        groupsVC.title = "Groups"
        groupsVC.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "rectangle.stack.person.crop"), selectedImage: UIImage(systemName: "rectangle.stack.person.crop.fill"))
        
        return UINavigationController(rootViewController: groupsVC)
    }
    
    func createNewsNC() -> UINavigationController {
        let newsVC = NewsVC()
        newsVC.title = "News"
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "face.smiling"), selectedImage: UIImage(systemName: "face.smiling.fill"))
        
        return UINavigationController(rootViewController: newsVC)
    }
}
