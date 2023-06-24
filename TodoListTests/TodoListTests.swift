//
//  TodoListTests.swift
//  TodoListTests
//
//  Created by Егор Черняев on 15.06.2023.
//

import XCTest
@testable import TodoList  // Замените на имя вашего модуля

class TodoItemTests: XCTestCase {
    
    // Функция, которая запускается перед каждым тестом
    override func setUp() {
        super.setUp()
    }
    
    // Функция, которая запускается после каждого теста
    override func tearDown() {
        super.tearDown()
    }
    
    func testTodoItemInit() {
        let todoItem = TodoItem(id: "1", text: "Test", priority: .medium, deadline: nil, isCompleted: false, creationDate: Date(), modificationDate: nil)
        XCTAssertEqual(todoItem.id, "1")
        XCTAssertEqual(todoItem.text, "Test")
        XCTAssertEqual(todoItem.priority, .medium)
        XCTAssertNil(todoItem.deadline)
        XCTAssertFalse(todoItem.isCompleted)
    }
    
    func testTodoItemParseFromJson() {
        let json: [String: Any] = [
            "id": "1",
            "text": "Test",
            "importance": "обычная",
            "isDone": false,
            "createDate": Date().timeIntervalSince1970
        ]
        
        let todoItem = TodoItem.parse(json: json)
        if let todoItem = todoItem {
            XCTAssertEqual(todoItem.id, "1")
            XCTAssertEqual(todoItem.text, "Test")
            XCTAssertEqual(todoItem.priority, .medium)
            XCTAssertFalse(todoItem.isCompleted)
        }
    }
    
    func testTodoItemParseFromCsv() {
        let csv = "1;Test;обычная;false;\(Int(Date().timeIntervalSince1970))"
        let todoItem = TodoItem.parse(csv: csv)
        XCTAssertNotNil(todoItem)
        if let todoItem = todoItem {
            XCTAssertEqual(todoItem.id, "1")
            XCTAssertEqual(todoItem.text, "Test")
            XCTAssertEqual(todoItem.priority, .medium)
            XCTAssertFalse(todoItem.isCompleted)
        }
    }
    func testToDoItemInit() {
        let id = "19"
        let text = "Write a Unit-test"
        let priority = Priority.high
        let deadline = Date().addingTimeInterval(360)
        let isCompleted = false
        let creationDate = Date()
        let modificationDate: Date? = nil
        
        let todoItem = TodoItem(id: id, text: text, priority: priority, deadline: deadline, isCompleted: isCompleted, creationDate: creationDate, modificationDate: modificationDate)
        
        XCTAssertEqual(todoItem.id, id)
        XCTAssertEqual(todoItem.text, text)
        XCTAssertEqual(todoItem.priority, priority)
        XCTAssertEqual(todoItem.deadline, deadline)
        XCTAssertEqual(todoItem.isCompleted, isCompleted)
        XCTAssertEqual(todoItem.creationDate, creationDate)
        XCTAssertEqual(todoItem.modificationDate, modificationDate)
    }
    
    // Проверка  метода `parseJSON`  (при некорректном JSON вернет nil)
    func testParseJSON_InvalidJSON_ReturnsNil() {
        let json: [String: Any] = [
            "id": "testID",
            "text": "Test todo item",
        ]
        
        let parsedItem = TodoItem.parse(json: json)
        XCTAssertNil(parsedItem)
    }
    
    
    func testTodoItemInitWithDefaultId() {
        let todoItem = TodoItem(text: "Test", priority: .medium, isCompleted: false)
        XCTAssertNotNil(todoItem.id)
    }
    
    func testTodoItemToJson() {
        let todoItem = TodoItem(id: "1", text: "Test", priority: .medium, deadline: nil, isCompleted: false, creationDate: Date(), modificationDate: nil)
        let json = todoItem.json as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? String, "1")
        XCTAssertEqual(json?["text"] as? String, "Test")
        XCTAssertEqual(json?["priority"] as? String, nil)
        XCTAssertTrue(json?["isComplited"] as? Bool ?? true)
    }
    func testTodoItemParseFromJsonMissingFields() {
        let json: [String: Any] = [
            "id": "1",
            "text": "Test",
            "isComplited": false,
            "creationDate": Date().timeIntervalSince1970
        ]
        
        let todoItem = TodoItem.parse(json: json)
        if let todoItem = todoItem {
            XCTAssertEqual(todoItem.id, "1")
            XCTAssertEqual(todoItem.text, "Test")
            XCTAssertEqual(todoItem.priority, .medium) // default importance
            XCTAssertFalse(todoItem.isCompleted)
        }
    }
    func testParsingCsv() {
        let csv = "789;Task 3;;false;1700000000"
        
        let todoItem = TodoItem.parse(csv: csv)
        
        XCTAssertNotNil(todoItem)
        XCTAssertEqual(todoItem?.id, "789")
        XCTAssertEqual(todoItem?.text, "Task 3")
        XCTAssertEqual(todoItem?.priority, .medium)
        XCTAssertNil(todoItem?.deadline)
        XCTAssertFalse(todoItem?.isCompleted ?? true)
        XCTAssertEqual(todoItem?.creationDate.timeIntervalSince1970, TimeInterval(1700000000))
        XCTAssertNil(todoItem?.modificationDate)
    }
    
    func testFormattingCsv() {
        let todoItem = TodoItem(
            id: "999",
            text: "Task 4",
            priority: .low,
            deadline: Date(),
            isCompleted: true,
            creationDate: Date(),
            modificationDate: Date()
        )
        
        let csv = todoItem.csv
        
        XCTAssertEqual(csv, "999;Task 4;неважная;true;\(Int(todoItem.creationDate.timeIntervalSince1970));\(Int(todoItem.deadline?.timeIntervalSince1970 ?? 0))")
    }
    func testParsingJsonMissingFields() {
        // JSON без некоторых обязательных полей
        let json: [String: Any] = [
            "id": "123",
            "text": "Task 1",
            "isCompleted": true,
            "creationDate": 1666666666
        ]
        
        let todoItem = TodoItem.parse(json: json)
    }
    
    func testFormattingJsonWithModificationDate() {
        // Форматирование JSON с датой модификации
        let todoItem = TodoItem(
            id: "456",
            text: "Task 2",
            priority: .medium,
            deadline: nil,
            isCompleted: false,
            creationDate: Date(),
            modificationDate: Date()
        )
        
        let json = todoItem.json as? [String: Any]
        
        XCTAssertNotNil(json)
        XCTAssertNotNil(json?["modificationDate"] as? TimeInterval)
    }
    
    func testParsingCsvInvalidFormat() {
        let csv = "789;Task 3;medium;false"
        
        let todoItem = TodoItem.parse(csv: csv)
        
        XCTAssertNil(todoItem)
    }
    
    func testFormattingCsvWithDeadline() {
        let todoItem = TodoItem(
            id: "999",
            text: "Task 4",
            priority: .low,
            deadline: Date(timeIntervalSince1970: 1728000000),
            isCompleted: true,
            creationDate: Date(),
            modificationDate: nil
        )
        
        let csv = todoItem.csv
        
        XCTAssertEqual(csv, "999;Task 4;неважная;true;\(Int(todoItem.creationDate.timeIntervalSince1970));1728000000")
    }
    
    func testParsingCsvWithEmptyPriority() {
        // Парсинг CSV с пустым полем приоритета
        let csv = "123;Task 5;;false;1666666666"
        
        let todoItem = TodoItem.parse(csv: csv)
        
        XCTAssertNotNil(todoItem)
        XCTAssertEqual(todoItem?.priority, .medium)
    }
    func testFormattingCsvWithoutDeadline() {
        // Форматирование CSV без даты дедлайна
        let todoItem = TodoItem(
            id: "555",
            text: "Task 6",
            priority: .high,
            deadline: nil,
            isCompleted: false,
            creationDate: Date(),
            modificationDate: nil
        )
        
        let csv = todoItem.csv
        
        XCTAssertEqual(csv, "555;Task 6;важная;false;\(Int(todoItem.creationDate.timeIntervalSince1970))") // Не должно быть записи даты дедлайна
    }
    
    func testParsingJsonWithInvalidDate() {
        // Парсинг JSON с некорректной датой
        let json: [String: Any] = [
            "id": "789",
            "text": "Task 7",
            "priority": "medium",
            "isCompleted": false,
            "creationDate": "invalid date"
        ]
        
        let todoItem = TodoItem.parse(json: json)
        
        XCTAssertNil(todoItem)
    }
    
    func testFormattingJsonWithoutModificationDate() {
        let todoItem = TodoItem(
            id: "987",
            text: "Task 8",
            priority: .medium,
            deadline: nil,
            isCompleted: true,
            creationDate: Date(),
            modificationDate: nil
        )
        
        let json = todoItem.json as? [String: Any]
        
        XCTAssertNotNil(json)
        XCTAssertNil(json?["modificationDate"])
    }
    func testParsingJsonWithMissingText() {
        // Парсинг JSON с отсутствующим текстом
        let json: [String: Any] = [
            "id": "111",
            "priority": "high",
            "isCompleted": true,
            "creationDate": Date().timeIntervalSince1970
        ]
        
        let todoItem = TodoItem.parse(json: json)
        
        XCTAssertNil(todoItem)
    }
    
    func testParsingCsvWithInvalidDate() {
        // Парсинг CSV с некорректной датой
        let csv = "333;Task 3;medium;false;invalid_date"
        
        let todoItem = TodoItem.parse(csv: csv)
    }
    
    func testParsingJsonWithInvalidDeadline() {
        // Парсинг JSON с некорректным значением дедлайна
        let json: [String: Any] = [
            "id": "555",
            "text": "Task 5",
            "priority": "low",
            "isCompleted": false,
            "creationDate": Date().timeIntervalSince1970,
            "deadline": "invalid_date"
        ]
        
        let todoItem = TodoItem.parse(json: json)
        
        XCTAssertNotNil(todoItem)
        XCTAssertNil(todoItem?.deadline)
    }
    
    func testFormattingCsvWithMissingId() {
        // Форматирование CSV с отсутствующим значением id
        let todoItem = TodoItem(
            id: "",
            text: "Task 6",
            priority: .high,
            deadline: Date(),
            isCompleted: false,
            creationDate: Date(),
            modificationDate: nil
        )
        
        let csv = todoItem.csv
        
    }
}

