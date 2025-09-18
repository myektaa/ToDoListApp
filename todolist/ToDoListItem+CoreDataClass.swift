//
//  ToDoListItem+CoreDataClass.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 18.09.2025.
//
//

import Foundation
import CoreData
import UIKit

@objc(ToDoListItem)
public class ToDoListItem: NSManagedObject {
    
    
    convenience init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
        self.name = ""
    }
    
    convenience init(named name: String) {
        self.init()
        self.name = name
    }
    
}
