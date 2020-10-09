//
//  MyFriend+CoreDataProperties.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 09.10.2020.
//
//

import Foundation
import CoreData


extension MyFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyFriend> {
        return NSFetchRequest<MyFriend>(entityName: "MyFriend")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var userId: String?
    @NSManaged public var activity: String?

}

extension MyFriend : Identifiable {

}
