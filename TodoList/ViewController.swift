//
//  ViewController.swift
//  TodoList
//
//  Created by Егор Черняев on 15.06.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let fileCache = FileCache(fileName: "todos.json")
//
//        // Создаем несколько задач
//        let todo1 = TodoItem(id: "1", text: "Поесть", priority: .medium, isCompleted: true)
//        let todo2 = TodoItem(text: "Сделать упражнения", priority: .medium, isCompleted: false)
//        let todo3 = TodoItem(text: "Погулять", priority: .low, isCompleted: false)
//
//        //Добавляем задачи в кэш
//        fileCache.addTodoItem(todo1)
//        fileCache.addTodoItem(todo2)
//        fileCache.addTodoItem(todo3)
//
//        // Удаляем задачу по идентификатору
//        fileCache.removeTodoItem(id: todo1.id)
//
//        // Выводим список задач из кэша
//        print("Список задач:")
//        fileCache.todoItems.forEach { print($0) }
//
//
//
//
//        // При необходимости можно создать другой экземпляр FileCache для работы с другим файлом
//
//        // Создаем еще одну задачу
//        let todo4 = TodoItem(text: "Проверить почту", priority: .medium, isCompleted: false)
//
//        //Добавляем задачу в новый кэш
//        let otherFileCache = FileCache(fileName: "othertodos.json")
//        otherFileCache.addTodoItem(todo4)
//
//        // Выводим список задач из нового кэша
//        print("Список задач из другого кэша:")
//        otherFileCache.todoItems.forEach { print($0) }

        
        
        
        
        // Создание экземпляра FileCache и списка TodoItem
        let fileCache = FileCache(fileName: "test")


        // Загрузка списка дел из CSV файла
        fileCache.loadItemsFromCsv()

        // Вывод списка дел
        for item in fileCache.todoItems {
            print("\(item.id): \(item.text) - \(item.isCompleted ? "Готово" : "Не готово")")
        }
        
    }


}
