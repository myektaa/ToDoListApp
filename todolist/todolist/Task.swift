//
//  Task.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 13.08.2025.
//

import Foundation

struct Task {
    
    enum TaskPriority: Int, CaseIterable {
        case low = 0
        case medium = 1
        case high = 2
        
        var name: String {
            switch self {
            case .low:
                return "Düşük"
            case .medium:
                return "Orta"
            case .high:
                return "Yüksek"
            }
        }
    }
    
    var date: Date
    var name: String
    var priority: TaskPriority
    
    init(date: Date, name: String, priority: TaskPriority) {
        self.date = date
        self.name = name
        self.priority = priority
    }
    
    static let sampleTask: Task = {
        return Task(
            date: Date(),
            name: "",
            priority: .low
        )
    }()
}
