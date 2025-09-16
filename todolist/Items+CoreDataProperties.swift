//
//  Items+CoreDataProperties.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 16.09.2025.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var priority: Int16

}

extension ToDoListItem : Identifiable {

}
