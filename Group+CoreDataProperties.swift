//
//  Group+CoreDataProperties.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 09.10.2020.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var activity: String?
    @NSManaged public var groupId: String?
    @NSManaged public var name: String?

}

extension Group : Identifiable {

}
