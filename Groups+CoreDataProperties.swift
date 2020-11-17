//
//  Groups+CoreDataProperties.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 17.11.2020.
//
//

import Foundation
import CoreData


extension Groups {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Groups> {
        return NSFetchRequest<Groups>(entityName: "Groups")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var avatarUrl: String?

}

extension Groups : Identifiable {

}
