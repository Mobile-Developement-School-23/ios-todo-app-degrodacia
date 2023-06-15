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
        XCTAssertNotNil(todoItem)
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
}
