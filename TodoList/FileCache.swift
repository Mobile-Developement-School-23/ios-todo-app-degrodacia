//
//  FileCache.swift
//  TodoList
//
//  Created by Егор Черняев on 15.06.2023.
//

import Foundation

final class FileCache {
    var todoItems: [TodoItem] = []
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
        loadFromJSON()
    }
    
    func addTodoItem(_ todoItem: TodoItem) {
        if let existingIndex = todoItems.firstIndex(where: { $0.id == todoItem.id }) {
            todoItems[existingIndex] = todoItem
        } else {
            todoItems.append(todoItem)
        }
        
        saveToJSON()
    }
    
    func removeTodoItem(id: String) {
        todoItems.removeAll(where: { $0.id == id })
        saveToJSON()
    }
    
    private func saveToJSON() {
        let json = todoItems.map { $0.json }
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let fileURL = getFileURL() {
            do {
                try jsonData.write(to: fileURL)
            } catch {
                print("Failed to save JSON data to file: \(error)")
            }
        }
    }
    
    private func loadFromJSON() {
        guard let fileURL = getFileURL(),
              let jsonData = try? Data(contentsOf: fileURL),
              let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: []),
              let todoItemsArray = jsonArray as? [Any]
        else {
            return
        }
        
        todoItems = todoItemsArray.compactMap { json in
            if let todoItemJSON = json as? [String: Any],
               let todoItem = TodoItem.parse(json: todoItemJSON) {
                return todoItem
            }
            return nil
        }
    }
     
    private func getFileURL() -> URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentDirectory?.appendingPathComponent(fileName)
        return fileURL
    }
}



// MARK: FileCache extension for  CSV
extension FileCache {
    func saveItemsToCsv() {
        let csvText = todoItems.map { $0.csv }.joined(separator: "\n")
        if let fileURL = getFileURL(with: self.fileName, extension: "csv") {
            do {
                try csvText.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                print("Проблема при сохранении в CSV файл: \(error.localizedDescription)")
            }
        }
    }
    
    func loadItemsFromCsv() {
        guard let fileURL = getFileURL(with: self.fileName, extension: "csv"),
              let csvText = try? String(contentsOf: fileURL, encoding: .utf8) else {
            return
        }
        
        let csvRows = csvText.components(separatedBy: "\n")
        guard let headerRow = csvRows.first, validate(header: headerRow) else {
            return
        }
        
        let dataRows = Array(csvRows.dropFirst()) // Исключаем строку заголовка
        
        todoItems = dataRows.compactMap { csvRow in
            let csvColumns = csvRow.components(separatedBy: ";")
            
            let id = csvColumns[0]
            let text = csvColumns[1]
            let priorityString = csvColumns[2]
            let isCompletedString = csvColumns[3]
            let deadlineString = csvColumns[4]
            let creationDateString = csvColumns[5]
            let modificationDateString = csvColumns[6]
            
            let priority: Priority
            if priorityString.isEmpty || priorityString == "обычная" {
                priority = .medium
            } else {
                priority = Priority(rawValue: priorityString) ?? .medium
            }
            
            let isCompleted = isCompletedString == "true"
            let deadline = deadlineString.isEmpty ? nil : Date(timeIntervalSince1970: TimeInterval(deadlineString)!)
            let creationDate = Date(timeIntervalSince1970: TimeInterval(creationDateString)!)
            let modificationDate = modificationDateString.isEmpty ? nil : Date(timeIntervalSince1970: TimeInterval(modificationDateString)!)
            
            return TodoItem(id: id, text: text, priority: priority, deadline: deadline, isCompleted: isCompleted, creationDate: creationDate, modificationDate: modificationDate)
        }
    }
    
    private func validate(header: String) -> Bool {
        let expectedColumnCount = 7
        let headerColumns = header.components(separatedBy: ";")
        return headerColumns.count == expectedColumnCount
    }
    
    private func getFileURL(with fileName: String, extension ext: String) -> URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentDirectory?.appendingPathComponent(fileName).appendingPathExtension(ext)
        return fileURL
    }
}
