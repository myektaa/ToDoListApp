//
//  TaskStore.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 1.09.2025.
//

import Foundation

public final class TaskStore {
    
    static let shared = TaskStore()
    
    private var tasks: [Task] = []
    
    public var favoriteTasks: [Task] {
        return tasks.filter(\.isFavorited)
    }
    
    public var completedTasks: [Task] {
        return tasks.filter(\.isCompleted)
    }
    
    public var todoTasks: [Task] {
        return tasks.filter({ $0.isCompleted == false && $0.isFavorited == false })
    }
    
    public func addTask(task: Task) {
        tasks.insert(task, at: 0)
    }
    
    public func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    public func updateTask(newTask: Task) throws {
        if let index = tasks.firstIndex(where: { $0.uuid == newTask.uuid }) {
            tasks.remove(at: index)
            tasks.insert(newTask, at: index)
        } else {
            throw TaskError.updateError("Task cannot be updated: index not found")
        }
    }
    
    public func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    public func removeTask(withUUID uuid: String) throws {
        if let index = tasks.firstIndex(where: { $0.uuid == uuid }) {
            tasks.remove(at: index)
        } else {
            throw TaskError.removeUUID("Task cannot be removed: index not found")
        }
    }
}

public enum TaskError: Error {
    case updateError(String)
    case removeUUID(String)
}
