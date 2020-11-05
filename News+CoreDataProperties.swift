//
//  News+CoreDataProperties.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 03.11.2020.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var date: Int64
    @NSManaged public var likes: Int16
    @NSManaged public var comments: Int16
    @NSManaged public var reposts: Int16
    @NSManaged public var show: Int16
    @NSManaged public var sourceId: Int64
    @NSManaged public var text: String?

}

extension News : Identifiable {

}
