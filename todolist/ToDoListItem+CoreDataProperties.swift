//
//  ToDoListItem+CoreDataProperties.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 18.09.2025.
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
    @NSManaged public var isFavorited: Bool
    @NSManaged public var isCompleted: Bool

}

extension ToDoListItem : Identifiable {

}
