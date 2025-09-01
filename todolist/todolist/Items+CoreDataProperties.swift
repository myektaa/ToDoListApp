//
//  Items+CoreDataProperties.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 1.09.2025.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var priority: Int16

}

extension Items : Identifiable {

}
