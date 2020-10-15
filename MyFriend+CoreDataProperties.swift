//
//  MyFriend+CoreDataProperties.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 13.10.2020.
//
//

import Foundation
import CoreData


extension MyFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyFriend> {
        return NSFetchRequest<MyFriend>(entityName: "MyFriend")
    }

    @NSManaged public var city: String?
    @NSManaged public var avatarUrl: String
    @NSManaged public var firstName: String
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String

}

extension MyFriend : Identifiable {

}
