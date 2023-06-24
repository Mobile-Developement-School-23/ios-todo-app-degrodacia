//
//  TodoItem.swift
//  TodoList
//
//  Created by Егор Черняев on 15.06.2023.
//

import Foundation


enum Priority: String {
    case low = "неважная"
    case medium = "обычная"
    case high = "важная"
}



struct TodoItem {
    let id: String
    let text: String
    let priority: Priority
    let deadline: Date?
    let isCompleted: Bool
    let creationDate: Date
    let modificationDate: Date?
    
    // Инициализатор для задачи
    init(id: String? = nil, text: String, priority: Priority, deadline: Date? = nil, isCompleted: Bool, creationDate: Date = Date(), modificationDate: Date? = nil) {
        self.id = id ?? UUID().uuidString
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isCompleted = isCompleted
        self.creationDate = creationDate
        self.modificationDate = modificationDate
    }
    
}



// MARK: Parse JSON
extension TodoItem {
    static func parse(json: Any) -> TodoItem? {
        guard let jsonDict = json as? [String: Any],
              let text = jsonDict["text"] as? String,
              let isCompleted = jsonDict["isCompleted"] as? Bool,
              let creationDateTimestamp = jsonDict["creationDate"] as? TimeInterval else {
            return nil
        }
        
        let priorityRawValue = jsonDict["priority"] as? String ?? ""
        let priority = Priority(rawValue: priorityRawValue) ?? .medium
        
        var deadline: Date?
        if let deadlineTimestamp = jsonDict["deadline"] as? TimeInterval {
            deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        }
        
        var modificationDate: Date?
        if let modificationDateTimestamp = jsonDict["modificationDate"] as? TimeInterval {
            modificationDate = Date(timeIntervalSince1970: modificationDateTimestamp)
        }
        
        let creationDate = Date(timeIntervalSince1970: creationDateTimestamp)
        
        return TodoItem(text: text, priority: priority, deadline: deadline, isCompleted: isCompleted, creationDate: creationDate, modificationDate: modificationDate)
    }
    
    var json: Any {
        var jsonDict: [String: Any] = [
            "id": id,
            "text": text,
            "isCompleted": isCompleted
        ]
        
        if priority != .medium {
            jsonDict["priority"] = priority.rawValue
        }
        
        if let deadline = deadline {
            jsonDict["deadline"] = deadline.timeIntervalSince1970
        }
        
        if let modificationDate = modificationDate {
            jsonDict["modificationDate"] = modificationDate.timeIntervalSince1970
        }
        
        return jsonDict
    }
}



// MARK: Parse CSV
extension TodoItem {
    static func parse(csv: String) -> TodoItem? {
        let components = csv.components(separatedBy: ";")
        guard components.count >= 5 else { return nil }
        
        let id = components[0]
        let text = components[1]
        let priority: Priority = components[2] == "важная" ? .high :
        components[2] == "неважная" ? .low : .medium
        let isComplited = components[3] == "true"
        
        let creationDate = Date(timeIntervalSince1970: Double(components[4]) ?? Date().timeIntervalSince1970)
        
        var deadline: Date? = nil
        if components.count > 5 {
            deadline = Date(timeIntervalSince1970: Double(components[5]) ?? Date().timeIntervalSince1970)
        }
        
        return TodoItem(id: id, text: text, priority: priority, deadline: deadline, isCompleted: isComplited, creationDate: creationDate)
    }
    
    var csv: String {
        let idString = id
        let textString = text
        let priorityString: String
        if priority == .medium {
            priorityString = ""
        } else {
            priorityString = priority.rawValue
        }
        let isCompletedString = isCompleted ? "true" : "false"
        let deadlineString = deadline?.timeIntervalSince1970.description ?? ""
        let creationDateString = creationDate.timeIntervalSince1970.description
        let modificationDateString = modificationDate?.timeIntervalSince1970.description ?? ""
        
        return "\(idString);\(textString);\(priorityString);\(isCompletedString);\(deadlineString);\(creationDateString);\(modificationDateString)"
    }
}
