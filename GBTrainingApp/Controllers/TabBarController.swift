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
        
        viewControllers = [createNewsNC(), createFriendsNC(), createGroupsNC()]
        UITabBar.appearance().tintColor = .systemGreen
    }
    
    func createNewsNC() -> UINavigationController {
        let newsVC = NewsVC()
        newsVC.title = "News"
        newsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        return UINavigationController(rootViewController: newsVC)
    }
    
    func createFriendsNC() -> UINavigationController {
        let friendsVC = FriendsVC()
        friendsVC.title = "Friends"
        friendsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        return UINavigationController(rootViewController: friendsVC)
    }
    
    func createGroupsNC() -> UINavigationController {
        let groupsVC = GroupsVC()
        groupsVC.title = "Groups"
        groupsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        return UINavigationController(rootViewController: groupsVC)
    }
}
