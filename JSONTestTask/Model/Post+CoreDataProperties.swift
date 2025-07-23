//
//  Post+CoreDataProperties.swift
//  JSONTestTask
//
//  Created by Даниил Иваньков on 22.07.2025.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var userId: Int64

}

extension Post : Identifiable {

}
