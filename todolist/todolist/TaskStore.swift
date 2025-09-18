//
//  TaskStore.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 1.09.2025.
//

import UIKit

public final class TaskStore {
    
    static let shared = TaskStore()
    
    private var tasks: [ToDoListItem] = []
    
    init(){
        getAllItems()
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllItems(){
        do {
            tasks = try context.fetch(ToDoListItem.fetchRequest())
            
        } catch {
            
        }
    }
    
    func createItems(name:String){
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.date = Date()
        newItem.priority = 0
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    
    
    
    public var favoriteTasks: [ToDoListItem] {
        return tasks.filter({ $0.isCompleted == false && $0.isFavorited == true })
    }
    
    public var completedTasks: [ToDoListItem] {
        return tasks.filter({ $0.isCompleted == true })
    }
    
    public var todoTasks: [ToDoListItem] {
        return tasks.filter({ $0.isCompleted == false && $0.isFavorited == false })
    }
    
    public func addTask(task: ToDoListItem) {
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    
    public func task(at index: Int) -> ToDoListItem {
        return tasks[index]
    }
    
    public func updateTask(newTask: ToDoListItem) throws {
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    
    public func removeTask(withItem item: ToDoListItem) throws {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
}

public enum TaskError: Error {
    case updateError(String)
    case removeUUID(String)
}
