//
//  News+CoreDataProperties.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 13.11.2020.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var comments: Int64
    @NSManaged public var date: Int64
    @NSManaged public var likes: Int64
    @NSManaged public var name: String?
    @NSManaged public var reposts: Int64
    @NSManaged public var show: Int64
    @NSManaged public var sourceId: Int64
    @NSManaged public var text: String?
    @NSManaged public var image: String?

}

extension News : Identifiable {

}
