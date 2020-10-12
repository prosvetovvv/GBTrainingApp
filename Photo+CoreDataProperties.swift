//
//  Photo+CoreDataProperties.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 08.10.2020.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var userId: String?
    @NSManaged public var photoUrl: String?

}

extension Photo : Identifiable {

}
