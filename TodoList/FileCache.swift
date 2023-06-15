//
//  FileCache.swift
//  TodoList
//
//  Created by Егор Черняев on 15.06.2023.
//

import Foundation

class FileCache {
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




extension FileCache {
    func saveItemsToCsv() {
         let csvText = todoItems.map { $0.csv }.joined(separator: "\n")
         if let fileURL = getFileURL(with: self.fileName, extension: "csv") {
             do {
                 try csvText.write(to: fileURL, atomically: true, encoding: .utf8)
             } catch {
                 print("проблема при сохранении в csv файл: \(error.localizedDescription)")
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
         let dataRows = csvRows
         todoItems = dataRows.compactMap { csvRow in
             return TodoItem.parse(csv: csvRow)
         }
     }
    
    private func validate(header: String) -> Bool {
        // Здесь можно проверить, что структура заголовка соответствует ожидаемой.
        // Для простоты, мы просто проверим количество колонок
        return header.components(separatedBy: ";").count >= 5
    }

    private func getFileURL(with fileName: String, extension ext: String) -> URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentDirectory?.appendingPathComponent(fileName).appendingPathExtension(ext)
        return fileURL
    }
}

