//
//  Task.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 13.08.2025.
//

import Foundation

public struct Task {
    
    public enum TaskPriority: Int, CaseIterable {
        case low = 0
        case medium = 1
        case high = 2
        
        public var name: String {
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
        
    public var date: Date
    public var name: String
    public var priority: TaskPriority
    public let uuid: String
    
    public var isFavorited: Bool = false
    public var isCompleted: Bool = false
    public var isTask: Bool = false

    public init(date: Date, name: String, priority: TaskPriority) {
        self.date = date
        self.name = name
        self.priority = priority
        self.uuid = UUID().uuidString
    }
    
    public static let sampleTask: Task = {
        return Task(
            date: Date(),
            name: "",
            priority: .low
        )
    }()
}
